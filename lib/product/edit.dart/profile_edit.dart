import 'dart:io';
import 'package:akademi_bootcamp/core/components/app_bar/custom_app_bar.dart';
import 'package:akademi_bootcamp/core/components/image/cached_network_image_widget.card.dart';
import 'package:akademi_bootcamp/core/constants/image/image_constants.dart';
import 'package:akademi_bootcamp/core/constants/theme/theme_constants.dart';
import 'package:akademi_bootcamp/core/services/auth/auth_service.dart';
import 'package:akademi_bootcamp/core/services/firestore/firestore_manager.dart';
import 'package:akademi_bootcamp/core/services/storage/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../core/constants/memory/shared_prefs_keys.dart';
import '../../core/memory/shared_preferences_manager.dart';

class ProfileEditView extends StatefulWidget {
  const ProfileEditView({super.key});

  @override
  State<ProfileEditView> createState() => _ProfileEditViewState();
}

class _ProfileEditViewState extends State<ProfileEditView> {
  File? pickedImage;

  saveChanges() async {
    if (pickedImage != null) {
      String uid = AuthService.instance.uid ?? '';
      String? downloadURL = await StorageService.instance.uploadMedia(pickedImage!);
      if (downloadURL != null) {
        await FirestoreManager.instance.firestoreUpdate(collectionID: "users", docID: uid, key: 'photo_url', value: downloadURL);
        AuthService.instance.currentUser!.photoUrl = downloadURL;
        AuthService.instance.userData['photo_url'] = downloadURL;
        SharedPrefsManager.instance.setMapValue(SharedPrefsKeys.USER_DATA, AuthService.instance.userData);
      } else {
        print('Dosya yükleme hatası.');
      }

      if (downloadURL != null) {
        print('Dosya yükleme tamamlandı. İndirme URL\'si: $downloadURL');
      } else {
        print('Dosya yükleme hatası.');
      }
    } else {
      print("Hiçbir şey fotoğraf seçmediniz.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        context: context,
        centerTitle: "Profili Düzenle",
        center: AppBarWidgets.TITLE,
        right: AppBarWidgets.DONE,
        left: AppBarWidgets.BACK,
        leftIconColor: AppColors.vanillaShake,
        onTapLeft: () => Navigator.of(context).pop(),
        onTapRight: saveChanges,
      ),
      body: Column(
        children: [
          photo(),
          changePhotoButton(),
        ],
      ),
    );
  }

  TextButton changePhotoButton() {
    return TextButton(
        onPressed: () => imagePickerOption(),
        child: Text(
          "Profili Düzenle",
          style: TextStyle(color: Colors.green),
        ));
  }

  Center photo() {
    return Center(
      child: Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(100))),
          child: ClipOval(
              child: pickedImage == null
                  ? AuthService.instance.currentUser!.photoUrl != null
                      ? cachedNetworkImageWidget(posterUrl: AuthService.instance.currentUser!.photoUrl, width: 150, height: 150)
                      : Image.asset(ImageConstants.HOME)
                  : Image.file(pickedImage!, width: 150, height: 150, fit: BoxFit.cover))),
    );
  }

  pickImage(ImageSource imageType) async {
    try {
      final photo = await ImagePicker().pickImage(source: imageType);
      if (photo == null) return;
      File tempImage = File(photo.path);
      setState(() {
        pickedImage = tempImage;
      });
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  void imagePickerOption() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            color: Colors.black,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Fotoğrafı Değiştir", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
              SizedBox(
                height: AppSizes.mediumSize,
              ),
              bottomSheetItem(icon: ImageConstants.GALLERY, imageSource: ImageSource.gallery, title: "Galeriden Seç", titleColor: AppColors.vanillaShake),
              bottomSheetItem(icon: ImageConstants.CAMERA, imageSource: ImageSource.camera, title: "Fotoğraf Çek", titleColor: AppColors.vanillaShake),
              bottomSheetItem(icon: ImageConstants.TRASH, title: "Mevcut Fotoğrafı Kaldır", titleColor: AppColors.red),
            ],
          ),
        );
      },
    );
  }

  InkWell bottomSheetItem({ImageSource? imageSource, required String icon, required String title, required Color titleColor}) {
    return InkWell(
      onTap: () {
        if (imageSource != null) {
          pickImage(imageSource);
          Navigator.of(context).pop();
        }
      },
      child: Padding(
        padding: EdgeInsets.all(AppSizes.lowSize / 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(icon),
            SizedBox(width: AppSizes.lowSize),
            Text(
              title,
              style: TextStyle(color: titleColor),
            )
          ],
        ),
      ),
    );
  }
}

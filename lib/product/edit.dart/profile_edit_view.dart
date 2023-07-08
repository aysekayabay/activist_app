import 'dart:io';
import 'dart:typed_data';

import 'package:akademi_bootcamp/core/components/app_bar/custom_app_bar.dart';
import 'package:akademi_bootcamp/core/constants/image/image_constants.dart';
import 'package:akademi_bootcamp/core/constants/theme/theme_constants.dart';
import 'package:akademi_bootcamp/product/edit.dart/profile_edit_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/components/image/profile_photo_widget.dart';

class ProfileEditView extends StatefulWidget {
  const ProfileEditView({super.key});

  @override
  State<ProfileEditView> createState() => _ProfileEditViewState();
}

class _ProfileEditViewState extends State<ProfileEditView> {
  ProfileEditViewModel _viewModel = ProfileEditViewModel();

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
        onTapRight: _viewModel.saveChanges,
      ),
      body: Column(
        children: [
          Observer(builder: (context) {
            return profilePhoto();
          }),
          changePhotoButton(),
        ],
      ),
    );
  }

  TextButton changePhotoButton() {
    return TextButton(
        onPressed: () => imagePickerOption(),
        child: Text(
          "Fotoğrafı Değiştir",
          style: TextStyle(color: Colors.green),
        ));
  }

  Widget profilePhoto() {
    if (_viewModel.pickedImage != null) {
      File file = _viewModel.pickedImage!;
      Uint8List bytes = file.readAsBytesSync();
      return CircleAvatar(radius: 75, backgroundColor: AppColors.bgColor, backgroundImage: MemoryImage(bytes));
    } else {
      return ProfilePhotoWidget(radius: 75);
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
          _viewModel.pickImage(imageSource);
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

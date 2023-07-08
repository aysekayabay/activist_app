import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';

import '../../core/services/storage/storage_service.dart';
part 'profile_edit_view_model.g.dart';

class ProfileEditViewModel = _ProfileEditViewModelBase with _$ProfileEditViewModel;

abstract class _ProfileEditViewModelBase with Store {
  @observable
  File? pickedImage;

  saveChanges() async {
    if (pickedImage != null) {
      await StorageService.instance.uploadMedia(pickedImage!);
    } else {
      print("Hiçbir fotoğraf seçilmedi.");
    }
  }

  @action
  pickImage(ImageSource imageType) async {
    try {
      final photo = await ImagePicker().pickImage(source: imageType);
      if (photo == null) return;
      File tempImage = File(photo.path);
      pickedImage = tempImage;
    } catch (error) {
      debugPrint(error.toString());
    }
  }
}

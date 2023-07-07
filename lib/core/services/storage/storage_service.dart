import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  StorageService._();
  static late final StorageService instance = StorageService._();
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  Future<String?> uploadMedia(File file) async {
    final storageRef = _firebaseStorage.ref();

    final mountainImagesRef = storageRef.child("images/1.jpg");

    try {
      await mountainImagesRef.putFile(file);
    } on FirebaseException catch (e) {
      print(e);
    }
  }

  getImageUrl() {}
}

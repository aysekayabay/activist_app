import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreManager {
  FirestoreManager._();
  static late final FirestoreManager instance = FirestoreManager._();
  final _firestore = FirebaseFirestore.instance;

  Future<Object?> firestoreGetDocument({required String collectionID, required String documentID}) async {
    DocumentReference documentRef = _firestore.collection(collectionID).doc(documentID);
    DocumentSnapshot document = await documentRef.get();
    Object? data = document.data();
    return data;
  }
}

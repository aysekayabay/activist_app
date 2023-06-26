import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreManager {
  FirestoreManager._();
  static late final FirestoreManager instance = FirestoreManager._();
  final _firestore = FirebaseFirestore.instance;

  Future<Object?> firestoreGetDocumentData({required String collectionID, required String docID}) async {
    DocumentReference documentRef = _firestore.collection(collectionID).doc(docID);
    DocumentSnapshot document = await documentRef.get();
    Object? data = document.data();
    return data;
  }

  Future<DocumentSnapshot<Object?>> firestoreGetDocument({required String collectionID, required String docID}) async {
    DocumentReference documentRef = _firestore.collection(collectionID).doc(docID);
    DocumentSnapshot document = await documentRef.get();
    return document;
  }

  Future<void> firestoreSendDataMap({required String collectionID, required String docID, required Map<String, dynamic> data}) async {
    await _firestore.collection(collectionID).doc(docID).set(data);
  }

  Future<void> firestoreUpdate({required String collectionID, required String docID, required String key, required dynamic value}) async {
    await _firestore.collection(collectionID).doc(docID).update({key: value});
  }

  Future<List<QueryDocumentSnapshot<dynamic>>> firestoreGetSomeDocuments({required String collectionID, required List<dynamic> whereIn}) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance.collection(collectionID).where(FieldPath.documentId, whereIn: whereIn).get();
    return querySnapshot.docs;
  }
}

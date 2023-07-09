import 'dart:async';
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

  Future<void> firestoreUpdateOneField({required String collectionID, required String docID, required String key, required dynamic value}) async {
    await _firestore.collection(collectionID).doc(docID).update({key: value});
  }

  Future<void> firestoreUpdateFields({
    required String collectionID,
    required String docID,
    required Map<String, dynamic> fields,
  }) async {
    final docRef = _firestore.collection(collectionID).doc(docID);
    await docRef.set(fields, SetOptions(merge: true));
  }

  Future<List<QueryDocumentSnapshot<dynamic>>> firestoreGetSomeDocuments({required String collectionID, required List<dynamic> whereIn}) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance.collection(collectionID).where(FieldPath.documentId, whereIn: whereIn).get();
    return querySnapshot.docs;
  }

  Stream<QuerySnapshot> firestoreGetSomeDocumentsAsStream({required String collectionID, required List<String> whereIn}) {
    return FirebaseFirestore.instance.collection(collectionID).where(FieldPath.documentId, whereIn: whereIn).snapshots();
  }

  Stream<DocumentSnapshot<Object?>> firestoreStreamDocument({required String collectionID, required String docID}) {
    StreamController<DocumentSnapshot<Object?>> controller = StreamController<DocumentSnapshot<Object?>>();

    _firestore.collection(collectionID).doc(docID).snapshots().listen((snapshot) {
      controller.add(snapshot);
    }, onError: (error) {
      controller.addError(error);
    });

    return controller.stream;
  }
}

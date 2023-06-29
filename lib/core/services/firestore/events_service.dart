import 'dart:async';

import 'package:akademi_bootcamp/core/model/message_model.dart';
import 'package:akademi_bootcamp/core/model/user_model.dart';
import 'package:akademi_bootcamp/core/services/auth/auth_service.dart';
import 'package:akademi_bootcamp/core/services/firestore/firestore_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../model/event_model.dart';
import '../../model/group_model.dart';

class EventsService {
  EventsService._();
  static late final EventsService instance = EventsService._();
  final GROUPS = 'groups';
  final USERS = 'users';
  final FAV_EVENTS = 'fav_events';

  Future<int> updateUserFavList(EventModel eventModel, bool adding) async {
    UserModel? user = AuthService.instance.currentUser;
    List<EventModel> favList = [];
    if (user != null) {
      if (user.favEvents == null && adding) {
        favList.add(eventModel);
        user.favEvents = favList;
      } else if (user.favEvents != null && adding) {
        favList = user.favEvents!;
        favList.add(eventModel);
      } else {
        //removing
        favList = user.favEvents!;
        favList.removeWhere((event) => event.id == eventModel.id);
      }
      final docFavList = [];

      for (final event in favList) {
        docFavList.add(event.toJson());
      }
      await FirestoreManager.instance.firestoreUpdate(collectionID: USERS, docID: user.userID!, key: FAV_EVENTS, value: docFavList);
      if (adding && eventModel.id != null && user.userID != null) {
        joinChatGroup(eventModel, user.userID!);
      }
      print(user.favEvents?.length ?? '');
      return 1;
    }
    return 0;
  }

  Stream<QuerySnapshot<Object?>>? fetchUserGroups() {
    UserModel? user = AuthService.instance.currentUser;

    if (user != null && user.favEvents != null && user.favEvents!.isNotEmpty) {
      List<String> favEventIds = user.favEvents!.map((event) => event.id.toString()).toList();

      return FirestoreManager.instance.firestoreGetSomeDocumentsAsStream(collectionID: "groups", whereIn: favEventIds);
    }
    return null;
  }

  Future<void> joinChatGroup(EventModel eventModel, String userID) async {
    if (eventModel.id != null) {
      DocumentSnapshot groupSnapshot = await FirestoreManager.instance.firestoreGetDocument(collectionID: GROUPS, docID: eventModel.id.toString());
      UserModel? currentUser = AuthService.instance.currentUser;
      if (groupSnapshot.exists) {
        GroupModel group = GroupModel.fromJson(groupSnapshot.data() as Map<String, dynamic>);
        List<SentBy> users = group.users ?? [];
        bool userExists = users.any((user) => user.id == userID);
        if (!userExists && currentUser != null) {
          users.add(SentBy(fullname: currentUser.fullname, id: currentUser.userID, photoUrl: currentUser.photoUrl));
          await groupSnapshot.reference.update({
            'users': users.map((user) => user.toJson()).toList(),
            'fav_count': FieldValue.increment(1),
          });
        }
      } else if (currentUser != null) {
        await FirestoreManager.instance.firestoreSendDataMap(collectionID: GROUPS, docID: eventModel.id.toString(), data: {
          'users': [SentBy(fullname: currentUser.fullname, id: currentUser.userID, photoUrl: currentUser.photoUrl).toJson()],
          'event': eventModel.toJson(),
          'messages': [],
          'fav_count': 1
        });
      }
    }
  }

  void leaveChatGroup(String eventID, String userID) async {
    dynamic data = await FirestoreManager.instance.firestoreGetDocumentData(collectionID: GROUPS, docID: eventID);
    if (data != null) {
      List<SentBy> users = (data[USERS] as List<dynamic>).map((item) => SentBy.fromJson(item)).toList();
      users.removeWhere((user) => user.id == userID);
      List<Map<String, dynamic>> updatedUsers = users.map((user) => user.toJson()).toList();
      await FirestoreManager.instance.firestoreUpdate(collectionID: GROUPS, docID: eventID, key: USERS, value: updatedUsers);
    }
  }

  pushMessage(String eventID, MessageModel message) async {
    DocumentSnapshot<Object?> firestoreGetDocument = await FirestoreManager.instance.firestoreGetDocument(collectionID: "groups", docID: eventID);
    Map<String, dynamic>? groupData = firestoreGetDocument.data() as Map<String, dynamic>?;
    if (groupData != null && groupData.containsKey("messages")) {
      List<dynamic> messages = groupData["messages"];
      messages.add(message.toJson());
      await FirestoreManager.instance.firestoreUpdate(collectionID: "groups", docID: eventID, key: "messages", value: messages);
    }
  }

  Stream<List<MessageModel>> getGroupChatsStream(String eventID) {
    StreamController<List<MessageModel>> controller = StreamController<List<MessageModel>>();

    FirestoreManager.instance.firestoreStreamDocument(collectionID: "groups", docID: eventID).listen((DocumentSnapshot<Object?> snapshot) {
      Map<String, dynamic>? groupData = snapshot.data() as Map<String, dynamic>?;

      if (groupData != null && groupData.containsKey("messages")) {
        List<dynamic> messageData = groupData["messages"];
        List<MessageModel> messages = messageData.map((data) => MessageModel.fromJson(data)).toList();

        controller.add(messages);
      } else {
        controller.add([]);
      }
    });

    return controller.stream;
  }
}

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

  Future<List<GroupModel>?> fetchUserGroups() async {
    UserModel? user = AuthService.instance.currentUser;
    List<DocumentSnapshot<Map<String, dynamic>>> groupsDocs = [];
    if (user != null && user.favEvents != null && user.favEvents!.isNotEmpty) {
      List<String> favEventIds = user.favEvents!.map((event) => event.id.toString()).toList();
      groupsDocs = (await FirestoreManager.instance.firestoreGetSomeDocuments(collectionID: GROUPS, whereIn: favEventIds)).cast<DocumentSnapshot<Map<String, dynamic>>>();
      List<GroupModel> groupList = groupsDocs.map((doc) => GroupModel.fromJson(doc.data()!)).toList();
      return groupList;
    }
    return null;
  }

  Future<void> joinChatGroup(EventModel eventModel, String userID) async {
    if (eventModel.id != null) {
      DocumentSnapshot groupSnapshot = await FirestoreManager.instance.firestoreGetDocument(collectionID: GROUPS, docID: eventModel.id.toString());
      if (groupSnapshot.exists) {
        GroupModel group = GroupModel.fromJson(groupSnapshot.data() as Map<String, dynamic>);
        List<UserModel> users = group.users ?? [];
        bool userExists = users.any((user) => user.userID == userID);
        if (!userExists) {
          users.add(UserModel(userID: userID));
          await groupSnapshot.reference.update({
            'users': users.map((user) => user.toJson()).toList(),
            'fav_count': FieldValue.increment(1),
          });
        }
      } else {
        await FirestoreManager.instance.firestoreSendDataMap(collectionID: GROUPS, docID: eventModel.id.toString(), data: {
          'users': [UserModel(userID: userID).toJson()],
          'event': eventModel.toJson(),
          'messages': [],
          'fav_count': 1
        });
      }
    }
  }

  leaveChatGroup(String eventID, String userID) async {
    try {
      dynamic data = await FirestoreManager.instance.firestoreGetDocumentData(collectionID: GROUPS, docID: eventID) as Map;
      if (data != null) {
        List<dynamic> users = data[USERS] ?? [];
        users.remove(userID);
        await FirestoreManager.instance.firestoreUpdate(collectionID: GROUPS, docID: eventID, key: USERS, value: users);
      }
    } catch (e) {}
  }
}

import 'package:akademi_bootcamp/core/model/user_model.dart';
import 'package:akademi_bootcamp/core/services/auth/auth_service.dart';
import 'package:akademi_bootcamp/core/services/firestore/firestore_manager.dart';
import '../../model/event_model.dart';

class EventsService {
  EventsService._();
  static late final EventsService instance = EventsService._();

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
      await FirestoreManager.instance.firestoreUpdate(collectionID: "users", docID: user.userID!, key: "fav_events", value: docFavList);
      print(user.favEvents?.length ?? '');
      return 1;
    }
    return 0;
  }

  fetchGroups() async {
    UserModel? user = AuthService.instance.currentUser;
    List? groupList;
    if (user != null) {
      groupList = await FirestoreManager.instance.firestoreGetSomeDocuments(collectionID: "groups", docID: "id", whereIn: user.favEvents);
    }
    groupList = groupList ?? [];
  }
}

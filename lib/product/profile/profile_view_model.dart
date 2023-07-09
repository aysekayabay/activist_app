import 'dart:typed_data';

import 'package:akademi_bootcamp/core/model/event_model.dart';
import 'package:akademi_bootcamp/core/model/user_model.dart';
import 'package:akademi_bootcamp/core/services/auth/auth_service.dart';
import 'package:akademi_bootcamp/core/services/firestore/events_service.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../core/model/group_model.dart';
import '../../core/services/storage/storage_service.dart';
part 'profile_view_model.g.dart';

class ProfileViewModel = _ProfileViewModelBase with _$ProfileViewModel;

abstract class _ProfileViewModelBase with Store {
  @observable
  UserModel? currentUser = AuthService.instance.currentUser;

  @observable
  Future<Uint8List?>? ppicFuture;

  @observable
  List<GroupModel> favEventsGroups = [];

  @observable
  bool isLoading = true;

  @action
  bool containsUser(GroupModel groupModel) => groupModel.users != null ? groupModel.users!.any((user) => user.id == currentUser?.userID) : false;

  @action
  leaveGroup(BuildContext context, EventModel? eventModel) {
    if (currentUser != null && currentUser!.userID != null && eventModel != null) {
      EventsService.instance.leaveChatGroup(eventModel.id.toString(), currentUser!.userID!);
      favEventsGroups.removeWhere((group) => group.event?.id == eventModel.id);
    }
  }

  @action
  joinGroup(BuildContext context, EventModel? eventModel) {
    if (currentUser != null && currentUser!.userID != null && eventModel != null) {
      EventsService.instance.joinChatGroup(eventModel, currentUser!.userID!);
    }
  }

  @action
  init() async {
    ppicFuture = StorageService.instance.downloadPPic(AuthService.instance.currentUser?.photoUrl);
  }

  @action
  removeFav(EventModel eventModel) {
    EventsService.instance.updateUserFavList(eventModel, false);
  }
}

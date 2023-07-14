import 'dart:typed_data';

import 'package:akademi_bootcamp/core/model/event_model.dart';
import 'package:akademi_bootcamp/core/model/user_model.dart';
import 'package:akademi_bootcamp/core/services/auth/auth_service.dart';
import 'package:akademi_bootcamp/core/services/firestore/events_service.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../core/model/group_model.dart';
part 'profile_view_model.g.dart';

class ProfileViewModel = _ProfileViewModelBase with _$ProfileViewModel;

abstract class _ProfileViewModelBase with Store {
  @observable
  UserModel? currentUser = AuthService.instance.currentUser;

  @observable
  Future<Uint8List?>? ppicFuture;

  @observable
  bool isLoading = true;

  @action
  bool containsUser(GroupModel groupModel) => groupModel.users != null ? groupModel.users!.any((user) => user.id == currentUser?.userID) : false;

  @action
  leaveGroup(BuildContext context, EventModel? eventModel) {
    if (currentUser != null && currentUser!.userID != null && eventModel != null) {
      EventsService.instance.leaveChatGroup(eventModel.id.toString(), currentUser!.userID!);
    }
  }

  @observable
  Map<String, int> categoryCountMap = {};

  @action
  countFavEventCategories(List<GroupModel> favEventsGroups) {
    categoryCountMap.clear();
    for (GroupModel group in favEventsGroups) {
      String? category = group.event?.category?.name;
      if (category != null) {
        if (categoryCountMap.containsKey(category)) {
          categoryCountMap[category.toString()] = categoryCountMap[category]! + 1;
        } else {
          categoryCountMap[category.toString()] = 1;
        }
      }
    }
    isLoading = false;
  }

  @action
  joinGroup(BuildContext context, EventModel? eventModel) {
    if (currentUser != null && currentUser!.userID != null && eventModel != null) {
      EventsService.instance.joinChatGroup(eventModel, currentUser!.userID!);
    }
  }

  @action
  removeFav(EventModel eventModel) {
    EventsService.instance.updateUserFavList(eventModel, false);
    String? category = eventModel.category?.name;
    if (category != null && categoryCountMap.containsKey(category)) {
      int count = categoryCountMap[category] ?? 0;
      if (count > 0) {
        categoryCountMap[category] = count - 1;
      }
      // if (count == 1) {
      //   categoryCountMap.remove(category);
      // }
    }
  }
}

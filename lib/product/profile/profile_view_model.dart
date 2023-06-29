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
  UserModel? currentUser = AuthService.instance.currentUser;

  @observable
  List<GroupModel> groups = [];

  @observable
  bool isLoading = true;

  leaveGroup(BuildContext context, EventModel? eventModel) {
    if (currentUser != null && currentUser!.userID != null && eventModel != null) {
      EventsService.instance.leaveChatGroup(eventModel.id.toString(), currentUser!.userID!);
    }
  }

  joinGroup(EventModel? eventModel, context) {
    if (currentUser != null && currentUser!.userID != null && eventModel != null) {
      EventsService.instance.joinChatGroup(eventModel, currentUser!.userID!);
    }
  }

  removeFav() {}
}

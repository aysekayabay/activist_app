import 'package:akademi_bootcamp/core/model/group_model.dart';
import 'package:akademi_bootcamp/core/services/firestore/events_service.dart';
import 'package:mobx/mobx.dart';
part 'groups_view_model.g.dart';

class GroupsViewModel = _GroupsViewModelBase with _$GroupsViewModel;

abstract class _GroupsViewModelBase with Store {
  @observable
  List<GroupModel> groups = [];

  @observable
  bool isLoading = true;

  @action
  getGroups() async {
    groups = await EventsService.instance.fetchUserGroups() ?? [];
    isLoading = false;
  }
}
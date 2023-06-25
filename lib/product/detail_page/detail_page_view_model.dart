import 'package:akademi_bootcamp/core/model/user_model.dart';
import 'package:akademi_bootcamp/core/services/auth/auth_service.dart';
import 'package:akademi_bootcamp/core/services/firestore/events_service.dart';
import 'package:mobx/mobx.dart';

import '../../core/model/event_model.dart';
part 'detail_page_view_model.g.dart';

class DetailPageViewModel = _DetailPageViewModelBase with _$DetailPageViewModel;

abstract class _DetailPageViewModelBase with Store {
  @observable
  List<EventModel> favList = [];
  @observable
  bool isFav = false;

  @action
  Future<void> favButton(EventModel event) async {
    if (!isFav) {
      isFav = true;
      await EventsService.instance.updateUserFavList(event, true);
    } else {
      isFav = false;
      await EventsService.instance.updateUserFavList(event, false);
    }
  }

  @action
  init(EventModel eventModel) {
    UserModel? currentUser = AuthService.instance.currentUser;
    if (currentUser != null) {
      favList = currentUser.favEvents ?? [];
    }
    isFav = favList.any((event) => event.id == eventModel.id);
  }
}

import 'package:akademi_bootcamp/core/constants/memory/shared_prefs_keys.dart';
import 'package:akademi_bootcamp/core/memory/shared_preferences_manager.dart';
import 'package:akademi_bootcamp/core/model/user_model.dart';
import '../../core/constants/navigation/navigation_constants.dart';
import '../../core/init/navigation/navigation_service.dart';
import '../../core/services/auth/auth_service.dart';

class SplashViewmodel {
  pageGenerator() {
    bool openedBefore = SharedPrefsManager.instance.getBoolValue(SharedPrefsKeys.OPENED_BEFORE);
    if (!openedBefore) {
      SharedPrefsManager.instance.setBoolValue(SharedPrefsKeys.OPENED_BEFORE, true);
      return NavigationService.instance.navigateToPage(path: NavigationConstants.ONBOARD);
    } else {
      var uid = SharedPrefsManager.instance.getStringValue(SharedPrefsKeys.UID);
      if (uid != '') {
        AuthService.instance.uid = uid;
        dynamic userData = SharedPrefsManager.instance.getMapValue(SharedPrefsKeys.USER_DATA);
        AuthService.instance.currentUser = UserModel.fromJson(userData);
        AuthService.instance.userData = userData;
        NavigationService.instance.navigateToPage(path: NavigationConstants.APP_BASE);
      } else {
        return NavigationService.instance.navigateToPage(path: NavigationConstants.AUTH);
      }
    }
  }
}

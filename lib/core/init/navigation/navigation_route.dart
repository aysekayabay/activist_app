import 'package:akademi_bootcamp/core/constants/navigation/navigation_constants.dart';
import 'package:akademi_bootcamp/view/auth/login_view.dart';
import 'package:akademi_bootcamp/view/home/events_view.dart';
import 'package:flutter/material.dart';

import '../../components/cards/page/not_found_navigation.dart';

class NavigationRoute {
  NavigationRoute._();
  static late final NavigationRoute instance = NavigationRoute._();

  Route<dynamic> generateRoute(RouteSettings args) {
    switch (args.name) {
      case NavigationConstants.HOME:
        return navigate(EventsView());
      case NavigationConstants.LOGIN:
        return navigate(LoginView());
      default:
        MaterialPageRoute(builder: (context) => NotFoundNavigatonWidget());
    }
    return MaterialPageRoute(builder: (context) => NotFoundNavigatonWidget());
  }

  MaterialPageRoute<dynamic> navigate(Widget widget) {
    return MaterialPageRoute(builder: (context) => widget);
  }
}

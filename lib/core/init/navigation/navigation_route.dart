import 'package:akademi_bootcamp/core/constants/navigation/navigation_constants.dart';
import 'package:akademi_bootcamp/product/home/events_view.dart';
import 'package:flutter/material.dart';

import '../../../product/auth/auth_view.dart';
import '../../../product/home/home_view.dart';
import '../../components/page/not_found_navigation.dart';

class NavigationRoute {
  NavigationRoute._();
  static late final NavigationRoute instance = NavigationRoute._();

  Route<dynamic> generateRoute(RouteSettings args) {
    switch (args.name) {
      case NavigationConstants.HOME:
        return navigate(HomeView());
      case NavigationConstants.AUTH:
        return navigate(AuthView());
      case NavigationConstants.TEST:
        return navigate(EventsView());
      default:
        MaterialPageRoute(builder: (context) => NotFoundNavigatonWidget());
    }
    return MaterialPageRoute(builder: (context) => NotFoundNavigatonWidget());
  }

  MaterialPageRoute<dynamic> navigate(Widget widget) {
    return MaterialPageRoute(builder: (context) => widget);
  }
}

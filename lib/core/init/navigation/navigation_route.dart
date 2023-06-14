import 'package:akademi_bootcamp/core/constants/navigation/navigation_constants.dart';
import 'package:akademi_bootcamp/test_view.dart';
import 'package:flutter/material.dart';

import '../../components/cards/page/not_found_navigation.dart';

class NavigationRoute {
  NavigationRoute._();
  static late final NavigationRoute instance = NavigationRoute._();

  Route<dynamic> generateRoute(RouteSettings args) {
    switch (args.name) {
      case NavigationConstants.HOME:
        return navigate(TestView());
      default:
        MaterialPageRoute(builder: (context) => NotFoundNavigatonWidget());
    }
    return MaterialPageRoute(builder: (context) => NotFoundNavigatonWidget());
  }

  MaterialPageRoute<dynamic> navigate(Widget widget) {
    return MaterialPageRoute(builder: (context) => widget);
  }
}

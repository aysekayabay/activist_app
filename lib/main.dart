import 'package:akademi_bootcamp/core/init/navigation/navigation_route.dart';
import 'package:akademi_bootcamp/core/init/navigation/navigation_service.dart';
import 'package:akademi_bootcamp/core/init/theme/app_theme.dart';
import 'package:akademi_bootcamp/product/initialize/application_start.dart';
import 'package:akademi_bootcamp/product/splash/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  await ApplicationStart.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(<DeviceOrientation>[
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
        title: 'ActivitIST',
        debugShowCheckedModeBanner: false,
        theme: AppThemeDark.instance.theme,
        navigatorKey: NavigationService.instance.navigatorKey,
        onGenerateRoute: NavigationRoute.instance.generateRoute,
        home: SplashView());
  }
}

import 'package:akademi_bootcamp/core/components/navigation_bar/custom_navigation_bar.dart';
import 'package:akademi_bootcamp/core/constants/navigation/navigation_constants.dart';
import 'package:akademi_bootcamp/core/constants/theme/theme_constants.dart';
import 'package:akademi_bootcamp/core/init/navigation/navigation_service.dart';
import 'package:akademi_bootcamp/product/groups/groups_view.dart';
import 'package:akademi_bootcamp/product/home/home_view.dart';
import 'package:akademi_bootcamp/product/map/mapbox_map_view.dart';
import 'package:akademi_bootcamp/product/profile/profile_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../core/services/auth/auth_service.dart';

class AppBaseView extends StatefulWidget {
  const AppBaseView({super.key});

  @override
  State<AppBaseView> createState() => _AppBaseViewState();
}

class _AppBaseViewState extends State<AppBaseView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int currentIndex = 0;

  logOut() {
    AuthService.instance.signOut();
    Navigator.pop(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        backgroundColor: AppColors.white,
        key: _scaffoldKey,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: AppColors.grey),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(FirebaseAuth.instance.currentUser?.displayName ?? ''),
                  Text(FirebaseAuth.instance.currentUser?.email ?? ''),
                ],
              ),
            ),
            // ListTile(
            //   title: const Text('Hakkımızda'),
            //   onTap: () {},
            // ),
            // ListTile(
            //   title: const Text('Şartlar'),
            //   onTap: () {},
            // ),
            AuthService.instance.uid == null
                ? ListTile(
                    title: const Text(
                      'Giriş Yap',
                    ),
                    onTap: () {
                      NavigationService.instance.navigateToPage(path: NavigationConstants.AUTH);
                    })
                : ListTile(
                    tileColor: Colors.red,
                    title: const Text(
                      'Çıkış Yap',
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      logOut();
                    }),
          ],
        ),
      ),
      extendBody: true,
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: currentIndex,
        onIndexChanged: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
      body: _buildCurrentView(),
    );
  }

  Widget _buildCurrentView() {
    switch (currentIndex) {
      case 0:
        return HomeView(scaffoldKey: _scaffoldKey);
      case 1:
        return MapBoxView();
      case 2:
        return GroupsView();
      case 3:
        return ProfileView();
      default:
        return Container();
    }
  }
}

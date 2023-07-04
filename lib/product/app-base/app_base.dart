import 'package:akademi_bootcamp/core/components/navigation_bar/custom_navigation_bar.dart';
import 'package:akademi_bootcamp/product/groups/groups_view.dart';
import 'package:akademi_bootcamp/product/home/home_view.dart';
import 'package:akademi_bootcamp/product/map/mapbox_map_view.dart';
import 'package:akademi_bootcamp/product/profile/profile_view.dart';
import 'package:flutter/material.dart';

class AppBaseView extends StatefulWidget {
  const AppBaseView({super.key});

  @override
  State<AppBaseView> createState() => _AppBaseViewState();
}

class _AppBaseViewState extends State<AppBaseView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(key: _scaffoldKey),
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

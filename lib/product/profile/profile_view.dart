import 'package:akademi_bootcamp/core/base/state/base_state.dart';
import 'package:akademi_bootcamp/core/components/app_bar/custom_app_bar.dart';
import 'package:akademi_bootcamp/core/constants/image/image_constants.dart';
import 'package:akademi_bootcamp/core/constants/theme/theme_constants.dart';
import 'package:akademi_bootcamp/product/profile/profile_view_model.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends BaseState<ProfileView> {
  ProfileViewModel _viewModel = ProfileViewModel();
  @override
  void initState() {
    super.initState();
    print(_viewModel.currentUser?.fullname ?? '');
  }

  @override
  Widget build(BuildContext context) {
    bool hasPhotoUrl = _viewModel.currentUser != null && _viewModel.currentUser!.photoUrl != null;
    return Scaffold(
      appBar: CustomAppBar(context: context, center: AppBarWidgets.LOGO, right: AppBarWidgets.NOTIFICATION),
      body: Column(
        children: [
          Row(
            children: [
              profilePhoto(hasPhotoUrl),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(_viewModel.currentUser?.fullname ?? ''),
                  Row(children: [Image.asset(ImageConstants.LOCATION), Text("İstanbul")]),
                  CircularProgressIndicator(backgroundColor: Colors.transparent, valueColor: AlwaysStoppedAnimation<Color>(AppColors.vanillaShake), value: 0.2)
                ],
              )
            ],
          ),
          //   Expanded(
          //     child: SizedBox(
          //         height: deviceHeight,
          //         width: deviceWidth,
          //         child: ListView.builder(
          //             // itemCount: _viewModel.groups.length,
          //             itemBuilder: (context, index) => Slidable(
          //                 startActionPane: ActionPane(
          //                   motion: const ScrollMotion(),
          //                   children: [
          //                     SlidableAction(padding: EdgeInsets.zero, onPressed: (context) {}, backgroundColor: AppColors.red, foregroundColor: Colors.white, icon: Icons.delete, label: 'Grubu Sil')
          //                   ],
          //                 ),
          //                 child: GroupItemCard(
          //                   group: _viewModel.groups[index],
          //                   onTap: () {
          //                     Navigator.of(context).push(MaterialPageRoute(
          //                       builder: (context) {
          //                         return ChatView(groupModel: _viewModel.groups[index]);
          //                       },
          //                     ));
          //                   },
          //                 )))),
          //   )
        ],
      ),
    );
  }

  Container profilePhoto(bool hasPhotoUrl) {
    return Container(
        margin: EdgeInsets.all(AppSizes.mediumSize),
        decoration: BoxDecoration(
          borderRadius: AppRadius.primaryRadius,
          image: hasPhotoUrl
              ? DecorationImage(
                  image: NetworkImage(_viewModel.currentUser!.photoUrl!),
                  fit: BoxFit.cover,
                )
              : null,
        ),
        child: hasPhotoUrl ? SizedBox() : Icon(Icons.person_pin, size: 80),
        width: 100,
        height: 100);
  }
}

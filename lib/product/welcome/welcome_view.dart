import 'package:akademi_bootcamp/core/components/app_bar/custom_app_bar.dart';
import 'package:akademi_bootcamp/core/constants/image/image_constants.dart';
import 'package:akademi_bootcamp/core/constants/navigation/navigation_constants.dart';
import 'package:akademi_bootcamp/core/constants/theme/theme_constants.dart';
import 'package:akademi_bootcamp/core/init/navigation/navigation_service.dart';
import 'package:flutter/material.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image(image: AssetImage(ImageConstants.SPLASH_IMAGE), fit: BoxFit.cover, width: double.infinity, height: double.infinity),
          Positioned(
            left: AppSizes.mediumSize,
            bottom: MediaQuery.of(context).size.height / 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("THE BEST APP", style: Theme.of(context).textTheme.headlineSmall),
                Text("FOR", style: Theme.of(context).textTheme.headlineLarge),
                Text("YOUR", style: Theme.of(context).textTheme.headlineSmall),
                Text("ACTIVITIES", style: Theme.of(context).textTheme.headlineLarge),
              ],
            ),
          ),
          Positioned(
            bottom: AppSizes.mediumSize,
            right: 0,
            left: 0,
            child: CustomAppBar(
              context: context,
              center: AppBarWidgets.LOGO,
              right: AppBarWidgets.NEXT,
              onTapRight: () => NavigationService.instance.navigateToPageRemoved(path: NavigationConstants.ONBOARD),
            ),
          )
        ],
      ),
    );
  }
}

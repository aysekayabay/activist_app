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
            bottom: MediaQuery.of(context).size.height / 1.5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("FAVORİ ETKİNLİKLERİN", style: Theme.of(context).textTheme.headlineSmall),
                Text("CEBİNDE", style: Theme.of(context).textTheme.headlineLarge),
              ],
            ),
          ),
          Positioned(
            bottom: AppSizes.highSize + AppSizes.mediumSize,
            right: 0,
            left: 0,
            child: CustomAppBar(
              context: context,
              center: AppBarWidgets.LOGO,
              right: AppBarWidgets.NEXT,
              onTapRight: () => NavigationService.instance.navigateToPageRemoved(path: NavigationConstants.ONBOARD),
            ),
          ),
          Positioned(
              bottom: AppSizes.mediumSize,
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  "Bu uygulamadaki etkinlik verileri Etkinlik.io tarafından sağlanmaktadır.",
                  textAlign: TextAlign.center,
                ),
              ))
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../../constants/theme/theme_constants.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final bool isFilled;
  final String? iconPath;
  const CustomButton({super.key, required this.title, required this.isFilled, this.iconPath});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: AppSizes.mediumSize),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            iconPath != null ? Image.asset(iconPath.toString()) : SizedBox(),
            Text(title, style: TextStyle(color: isFilled ? Colors.black : Colors.white)),
          ],
        ),
      ),
      decoration: BoxDecoration(
          color: isFilled ? AppColors.vanillaShake : Colors.black,
          border: Border.all(width: 2, color: isFilled ? Colors.black : AppColors.vanillaShake),
          borderRadius: BorderRadius.all(Radius.circular(15))),
    );
  }
}

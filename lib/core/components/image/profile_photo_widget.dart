import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../../constants/theme/theme_constants.dart';
import '../../services/storage/storage_service.dart';

class ProfilePhotoWidget extends StatefulWidget {
  final double radius;
  const ProfilePhotoWidget({super.key, required this.radius});

  @override
  State<ProfilePhotoWidget> createState() => _ProfilePhotoWidgetState();
}

class _ProfilePhotoWidgetState extends State<ProfilePhotoWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uint8List?>(
      future: StorageService.instance.downloadPPic(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            final imageData = snapshot.data!;
            return CircleAvatar(
              backgroundColor: AppColors.bgColor,
              radius: widget.radius,
              backgroundImage: MemoryImage(imageData),
            );
          } else if (snapshot.hasError) {
            return CircleAvatar(
              backgroundColor: AppColors.vanillaShake,
              child: Icon(
                Icons.person,
                color: AppColors.bgColor,
              ),
            );
          } else {
            // situation null
            return CircleAvatar(
              backgroundColor: AppColors.vanillaShake,
              child: Icon(
                Icons.person,
                color: AppColors.bgColor,
              ),
            );
          }
        } else {
          // situation in progress
          return CircularProgressIndicator();
        }
      },
    );
  }
}

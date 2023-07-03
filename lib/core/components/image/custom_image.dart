import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../base/provider/internet_connection_provider.dart';

class CustomImage extends StatelessWidget {
  final String imageUrl;
  final String backupImagePath;
  final double? width;
  final double? height;
  final BoxFit? fit;

  CustomImage({
    required this.imageUrl,
    required this.backupImagePath,
    this.width,
    this.height,
    this.fit,
  });

  @override
  Widget build(BuildContext context) {
    final connectionStatus = Provider.of<InternetConnectionProvider>(context).connectionStatus;

    if (connectionStatus == ConnectionStatus.CONNECTED) {
      final updatedImageUrl = '$imageUrl?${DateTime.now().millisecondsSinceEpoch}';
      return Image.network(
        updatedImageUrl,
        width: width,
        height: height,
        fit: fit,
      );
    } else {
      return Image.asset(
        backupImagePath,
        width: width,
        height: height,
        fit: fit,
      );
    }
  }
}

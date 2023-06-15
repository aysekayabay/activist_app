import 'package:flutter/material.dart';

import '../../constants/theme/theme_constants.dart';
import '../../model/event_model.dart';

class PosterCard extends StatelessWidget {
  const PosterCard({
    super.key,
    required this.eventModel,
    required this.deviceWidth,
  });

  final EventModel eventModel;
  final double deviceWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 20),
      child: Image.network(
        eventModel.posterUrl!,
        width: deviceWidth - AppSizes.highSize,
      ),
    );
  }
}

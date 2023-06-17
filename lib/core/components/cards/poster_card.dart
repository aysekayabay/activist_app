import 'package:akademi_bootcamp/core/base/extensions/date_time_converter.dart';
import 'package:akademi_bootcamp/core/constants/image/image_constants.dart';
import 'package:akademi_bootcamp/core/constants/theme/theme_constants.dart';
import 'package:flutter/material.dart';

import '../../model/event_model.dart';

class PosterCard extends StatelessWidget {
  const PosterCard({
    super.key,
    required this.eventModel,
    required this.deviceWidth,
    required this.deviceHeight,
  });

  final EventModel eventModel;
  final double deviceWidth;
  final double deviceHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: deviceWidth * 0.8,
      height: deviceHeight / 2,
      padding: EdgeInsets.all(AppSizes.lowSize),
      decoration: BoxDecoration(color: AppColors.darkGrey.withOpacity(0.39), borderRadius: AppRadius.primaryRadius),
      margin: EdgeInsets.only(right: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(height: deviceHeight / 4, child: Align(alignment: Alignment.topCenter, child: ClipRRect(borderRadius: AppRadius.primaryRadius, child: Image.network(eventModel.posterUrl!)))),
          Text(eventModel.name!, maxLines: 1, style: TextStyle().copyWith(color: Colors.white)),
          Padding(padding: EdgeInsets.symmetric(vertical: AppSizes.mediumSize), child: Image.asset(ImageConstants.DIVIDER)),
          dateWidget(),
          timeWidget(),
          locationWidget(),
        ],
      ),
    );
  }

  Row locationWidget() {
    return Row(
      children: [
        Image.asset(ImageConstants.LOCATION),
        Flexible(child: Text(eventModel.venue!.name.toString(), overflow: TextOverflow.ellipsis, style: TextStyle().copyWith(color: Colors.white))),
      ],
    );
  }

  Row timeWidget() {
    return Row(
      children: [
        Icon(Icons.access_time_filled_rounded, color: AppColors.vanillaShake, size: 18),
        Text(eventModel.start!.formattedTime + '-' + eventModel.end!.formattedTime, style: TextStyle().copyWith(color: Colors.white)),
      ],
    );
  }

  Row dateWidget() {
    return Row(
      children: [Icon(Icons.calendar_month_rounded, color: AppColors.vanillaShake, size: 18), Text(eventModel.start!.formattedDate, style: TextStyle().copyWith(color: Colors.white))],
    );
  }
}

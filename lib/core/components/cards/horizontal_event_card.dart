// ignore_for_file: must_be_immutable

import 'package:akademi_bootcamp/core/base/extensions/date_time_converter.dart';
import 'package:akademi_bootcamp/core/constants/image/image_constants.dart';
import 'package:akademi_bootcamp/core/constants/theme/theme_constants.dart';
import 'package:flutter/material.dart';

import '../../model/event_model.dart';
import '../image/cached_network_image_widget.card.dart';

class HorizontalEventCard extends StatelessWidget {
  HorizontalEventCard({
    super.key,
    required this.eventModel,
    required this.deviceWidth,
    required this.deviceHeight,
    this.onTap,
  });

  final EventModel eventModel;
  final double deviceWidth;
  final double deviceHeight;
  void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSizes.lowSize),
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: deviceWidth * 0.8,
          height: deviceHeight / 2,
          padding: EdgeInsets.all(AppSizes.lowSize),
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                AppColors.darkGrey.withOpacity(0.39),
                Colors.transparent,
              ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
              borderRadius: AppRadius.primaryRadius),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              cachedNetworkImageWidget(posterUrl: eventModel.posterUrl, height: deviceHeight / 4, borderRadius: AppRadius.primaryRadius),
              Text(eventModel.name!, maxLines: 1, style: TextStyle().copyWith(color: Colors.white)),
              Padding(padding: EdgeInsets.symmetric(vertical: AppSizes.mediumSize), child: Image.asset(ImageConstants.DIVIDER)),
              dateWidget(),
              timeWidget(),
              locationWidget(),
            ],
          ),
        ),
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
      children: [
        Icon(Icons.calendar_month_rounded, color: AppColors.vanillaShake, size: 18),
        SizedBox(width: AppSizes.lowSize / 2),
        Text(eventModel.start!.formattedDate, style: TextStyle().copyWith(color: Colors.white)),
      ],
    );
  }
}

import 'package:akademi_bootcamp/core/base/extensions/date_time_converter.dart';
import 'package:akademi_bootcamp/core/model/event_model.dart';
import 'package:flutter/material.dart';

import '../../constants/theme/theme_constants.dart';

class EventItemCard extends StatelessWidget {
  const EventItemCard({
    super.key,
    required this.deviceWidth,
    required this.eventModel,
  });

  final double deviceWidth;
  final EventModel eventModel;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: AppSizes.lowSize),
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: AppSizes.lowSize),
            width: deviceWidth / 3,
            child: Align(
              alignment: Alignment.topCenter,
              child: Image.network(
                eventModel.posterUrl!,
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(eventModel.name!, overflow: TextOverflow.ellipsis, style: TextStyle().copyWith(color: AppColors.vanillaShake)),
                Text(eventModel.start!.formattedDay + ', ' + eventModel.start!.formattedTime, style: TextStyle().copyWith(color: AppColors.vanillaShake)),
                Text(eventModel.venue!.name!, overflow: TextOverflow.ellipsis, style: TextStyle().copyWith(color: AppColors.vanillaShake))
              ],
            ),
          ),
        ],
      ),
    );
  }
}

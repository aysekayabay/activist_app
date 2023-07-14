import 'package:akademi_bootcamp/core/base/extensions/date_time_converter.dart';
import 'package:akademi_bootcamp/core/components/image/cached_network_image_widget.card.dart';
import 'package:akademi_bootcamp/core/model/event_model.dart';
import 'package:flutter/material.dart';
import '../../constants/theme/theme_constants.dart';

class MapDetailCard extends StatelessWidget {
  final EventModel event;
  const MapDetailCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50),
      decoration: BoxDecoration(
          color: Colors.blueGrey[300],
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          cachedNetworkImageWidget(
              posterUrl: event.posterUrl,
              height: 150,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
          SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(padding: EdgeInsets.symmetric(horizontal: 8)),
                Text(
                  event.name ?? '',
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.displayMedium,
                  maxLines: 1,
                ),
                SizedBox(height: 5),
                Text(event.venue?.name ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium),
                SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    dateWidget(event.start.toString().formattedDate),
                    Column(
                      children: [
                        Icon(Icons.favorite,
                            size: AppSizes.mediumSize, color: AppColors.red),
                        Text(
                          '123',
                          style: TextStyle(fontSize: 10),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 5),
                timeWidget(event.start.toString().formattedTime +
                    "-" +
                    event.end.toString().formattedTime),
              ],
            ),
          ),
          // Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 20),
          //   child: MaterialButton(
          //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          //     onPressed: () {
          //       Navigator.of(context).push(MaterialPageRoute(
          //         builder: (context) {
          //           return DetailPage(eventModel: event);
          //         },
          //       ));
          //     },
          //     elevation: 6,
          //     color: AppColors.grey,
          //     child: Text(
          //       "İncele",
          //       style: Theme.of(context).textTheme.titleLarge,
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }

  Row timeWidget(String time) {
    return Row(
      children: [
        Padding(padding: EdgeInsets.all(8)),
        Icon(Icons.access_time,
            size: AppSizes.mediumSize, color: AppColors.vanillaShake),
        SizedBox(width: AppSizes.lowSize),
        Text(time,
            style: TextStyle(
                color: AppColors.vanillaShake,
                fontSize: 14,
                fontWeight: FontWeight.w400)),
      ],
    );
  }

  Row dateWidget(String date) {
    return Row(
      children: [
        Padding(padding: EdgeInsets.all(8)),
        Icon(Icons.calendar_month,
            size: AppSizes.mediumSize, color: AppColors.vanillaShake),
        SizedBox(width: AppSizes.lowSize),
        Text(date,
            style: TextStyle(
                color: AppColors.vanillaShake,
                fontSize: 14,
                fontWeight: FontWeight.w400)),
      ],
    );
  }
}

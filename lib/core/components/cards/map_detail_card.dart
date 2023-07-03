import 'package:akademi_bootcamp/core/components/image/custom_image.dart';
import 'package:akademi_bootcamp/core/constants/image/image_constants.dart';
import 'package:akademi_bootcamp/core/model/event_model.dart';
import 'package:akademi_bootcamp/product/detail_page/detail_page.dart';
import 'package:flutter/material.dart';

import '../../constants/theme/theme_constants.dart';

class MapDetailCard extends StatelessWidget {
  final EventModel event;
  const MapDetailCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 50),
      decoration: BoxDecoration(color: AppColors.vanillaShake, borderRadius: BorderRadius.all(Radius.circular(55))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 120,
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(55)),
              child: CustomImage(
                imageUrl: event.posterUrl!,
                backupImagePath: ImageConstants.AUTH_IMAGE,
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                event.name ?? '',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: AppColors.black),
                maxLines: 1,
              ),
              Text(event.venue?.name ?? '', maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(color: AppColors.black)),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: MaterialButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return DetailPage(eventModel: event);
                  },
                ));
              },
              elevation: 6,
              color: AppColors.orange,
              child: Text("İncele"),
            ),
          )
        ],
      ),
    );
  }
}

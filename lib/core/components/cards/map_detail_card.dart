import 'package:akademi_bootcamp/core/model/event_model.dart';
import 'package:flutter/material.dart';

import '../../constants/theme/theme_constants.dart';

class MapDetailCard extends StatelessWidget {
  final EventModel event;
  const MapDetailCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: AppSizes.mediumSize),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(child: Image.network(event.posterUrl ?? '')),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(event.name ?? ''),
                      Text(event.venue?.address ?? ''),
                    ],
                  ),
                )
              ],
            ),
          ),
          MaterialButton(
            padding: EdgeInsets.zero,
            onPressed: () {},
            elevation: 6,
            color: Color.fromARGB(255, 33, 212, 206),
            child: Text("İncele"),
          )
        ],
      ),
    );
  }
}

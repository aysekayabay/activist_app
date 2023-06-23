// ignore_for_file: unnecessary_null_comparison

import 'package:akademi_bootcamp/core/base/state/base_state.dart';
import 'package:akademi_bootcamp/core/constants/image/image_constants.dart';
import 'package:akademi_bootcamp/core/constants/theme/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class EventsMapView extends StatefulWidget {
  const EventsMapView({super.key});

  @override
  State<EventsMapView> createState() => _EventsMapViewState();
}

class _EventsMapViewState extends BaseState<EventsMapView> {
  CameraPosition cameraPosition = CameraPosition(target: LatLng(40.996149, 29.042611), zoom: 18);
  BitmapDescriptor museumIcon = BitmapDescriptor.defaultMarker;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: deviceHeight / 2,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: AppSizes.mediumSize),
            height: deviceHeight / 2,
            child: GoogleMap(
              initialCameraPosition: cameraPosition,
              mapType: MapType.normal,
              markers: {Marker(markerId: MarkerId("a"), position: cameraPosition.target, icon: museumIcon)},
              onMapCreated: (controller) {
                setState(() {
                  createMarkerFromAsset();
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> createMarkerFromAsset() async {
    final ImageConfiguration imageConfiguration = createLocalImageConfiguration(context);
    var bitmap = await BitmapDescriptor.fromAssetImage(imageConfiguration, "workshop".toPngFromIconAsset());
    setState(() {
      museumIcon = bitmap;
    });
  }

  Set<Marker> _createMarkers() {
    return <Marker>[Marker(markerId: MarkerId("a"), position: cameraPosition.target, icon: museumIcon)].toSet();
  }
}

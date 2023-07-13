import 'package:akademi_bootcamp/core/base/state/base_state.dart';
import 'package:akademi_bootcamp/core/components/cards/map_detail_card.dart';
import 'package:akademi_bootcamp/core/constants/api/api_constants.dart';
import 'package:akademi_bootcamp/core/constants/theme/theme_constants.dart';
import 'package:akademi_bootcamp/product/map/mapbox_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:latlong2/latlong.dart';
import '../../core/constants/image/image_constants.dart';
import '../../core/model/event_model.dart';

class MapBoxView extends StatefulWidget {
  const MapBoxView({super.key});

  @override
  State<MapBoxView> createState() => _MapBoxViewState();
}

class _MapBoxViewState extends BaseState<MapBoxView> {
  MapBoxViewModel _viewModel = MapBoxViewModel();
  @override
  void initState() {
    _viewModel.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Observer(builder: (_) {
      return Stack(
        children: [
          FlutterMap(
            options: MapOptions(
                maxZoom: 18,
                minZoom: 11,
                zoom: 11,
                center: _viewModel.currentPosition != null ? LatLng(_viewModel.currentPosition!.latitude, _viewModel.currentPosition!.longitude) : _viewModel.mapCenter),
            nonRotatedChildren: [
              TileLayer(
                urlTemplate: "https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}",
                additionalOptions: {'accessToken': ApiConstants.MAPBOX_ACCESS_TOKEN, 'id': _viewModel.MAPBOX_STYLE},
              ),
              _viewModel.currentPosition != null
                  ? MarkerLayer(markers: [Marker(point: LatLng(_viewModel.currentPosition!.latitude, _viewModel.currentPosition!.longitude), builder: (context) => userLocationMarker())])
                  : MarkerLayer(),
              MarkerLayer(markers: _viewModel.markerList)
            ],
          ),
          Visibility(visible: _viewModel.cardVisible, child: detailCardPageView(_viewModel.markerList))
        ],
      );
    }));
  }

  Positioned detailCardPageView(List<Marker> _markers) {
    return Positioned(
      top: AppSizes.highSize * 2,
      left: 0,
      right: 0,
      height: deviceHeight * 0.4,
      child: PageView.builder(
        controller: _viewModel.pageController,
        physics: NeverScrollableScrollPhysics(),
        itemCount: _markers.length,
        itemBuilder: (context, index) {
          final item = _viewModel.eventList[index];
          return MapDetailCard(event: item);
        },
      ),
    );
  }

  Container userLocationMarker() {
    return Container(
      child: Icon(
        Icons.location_pin,
        size: 30,
        color: Color.fromARGB(255, 18, 155, 141),
      ),
    );
  }

  Widget otherMarkers() {
    return Container();
  }
}

class LocationMarker extends StatelessWidget {
  final EventModel eventModel;
  final bool isSelected;
  const LocationMarker({super.key, this.isSelected = false, required this.eventModel});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedContainer(
        height: 30,
        width: 30,
        // height: isSelected ? 60.0 : 30.0,
        // width: isSelected ? 60.0 : 30.0,
        duration: Duration(milliseconds: 400),
        child: Image.asset(eventModel.markerIcon ?? ImageConstants.HOME),
      ),
    );
  }
}

import 'package:akademi_bootcamp/core/base/state/base_state.dart';
import 'package:akademi_bootcamp/core/components/cards/map_detail_card.dart';
import 'package:akademi_bootcamp/core/constants/api/api_constants.dart';
import 'package:akademi_bootcamp/core/constants/theme/theme_constants.dart';
import 'package:akademi_bootcamp/product/map/mapbox_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
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
    return Observer(builder: (_) {
      return Scaffold(
          body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(maxZoom: 19, minZoom: 11, zoom: 11, center: _viewModel.myLocation),
            nonRotatedChildren: [
              TileLayer(
                urlTemplate: "https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}",
                additionalOptions: {'accessToken': ApiConstants.MAPBOX_ACCESS_TOKEN, 'id': _viewModel.MAPBOX_STYLE},
              ),
              MarkerLayer(markers: [Marker(point: _viewModel.myLocation, builder: (context) => userLocationMarker())]),
              MarkerLayer(markers: _viewModel.markerList)
            ],
          ),
          Visibility(visible: _viewModel.selectedIndex != -1, child: detailCardPageView(_viewModel.markerList))
        ],
      ));
    });
  }

  Positioned detailCardPageView(List<Marker> _markers) {
    return Positioned(
      bottom: AppSizes.highSize,
      left: 0,
      right: 0,
      height: deviceHeight * 0.3,
      child: PageView.builder(
        controller: _viewModel.selectedIndex == -1 ? null : _viewModel.pageController,
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
      height: AppSizes.highSize,
      width: AppSizes.highSize,
      decoration: BoxDecoration(color: Color.fromARGB(255, 18, 155, 141), shape: BoxShape.circle),
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
      child:
          AnimatedContainer(height: isSelected ? 60.0 : 30.0, width: isSelected ? 60.0 : 30.0, duration: Duration(milliseconds: 400), child: Image.asset(eventModel.markerIcon ?? ImageConstants.HOME)),
    );
  }
}

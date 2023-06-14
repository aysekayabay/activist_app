import 'dart:convert';
import 'package:akademi_bootcamp/core/constants/api/api_constants.dart';
import 'package:akademi_bootcamp/core/model/event_model.dart';
import 'package:akademi_bootcamp/core/services/geocoding_service.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;

class EtkinlikIOService {
  List<EventModel>? eventList = [];
  late EventService eventService;

  Future<List<EventModel>?> fetchEventList() async {
    var response =
        await http.get(Uri.parse(ApiConstants.baseUrl + '/events?city_ids=40'), headers: {'Content-Type': 'application/json', 'Accept': 'application/json', 'X-Etkinlik-Token': ApiConstants.token});
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      eventService = EventService.fromJson(jsonResponse);
      await setVenueLocationInList();
      return eventService.eventList;
    } else {
      print(response.statusCode);
      return null;
    }
  }

  Future<void> setVenueLocationInList() async {
    if (eventService.eventList != null) {
      for (EventModel event in eventService.eventList!) {
        if (event.venue != null && event.venue?.lat == null && event.venue?.lng == null && event.venue?.address != null && event.venue!.address!.isNotEmpty) {
          Location? location = await GeocodingService().getLatLng(event.venue!.address.toString());
          if (location != null) {
            event.venue!.lat = location.latitude as String;
            event.venue!.lng = location.longitude as String;
          }
        }
      }
    }
  }
}

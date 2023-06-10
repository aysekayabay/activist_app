import 'dart:convert';

import 'package:akademi_bootcamp/constants/api_constants.dart';
import 'package:akademi_bootcamp/model/event_model.dart';
import 'package:http/http.dart' as http;

class EtkinlikIOService {
  Future<List<EventModel>?> fetchEventList() async {
    var response =
        await http.get(Uri.parse(ApiConstants.baseUrl + '/events?city_ids=40'), headers: {'Content-Type': 'application/json', 'Accept': 'application/json', 'X-Etkinlik-Token': ApiConstants.token});
    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      EventService eventService = EventService.fromJson(jsonResponse);
      return eventService.eventList;
      // print(eventService.eventList?.length.toString());
      // late EventModel? selected;
      // if (eventService.eventList != null) {
      //   for (EventModel element in eventService.eventList!) {
      //     if (element.venue?.id == 62873) {
      //       print(element.name.toString() + ' Mekan Adı:' + (element.venue?.name ?? ''));
      //       selected = element;
      //       break;
      //     }
      //   }
      // }
      // if (selected != null && selected.venue != null) {
      //   GeocodingService().getLatLng(selected.venue!.address.toString());
      // }
    } else {
      print(response.statusCode);
      return null;
    }
  }
}

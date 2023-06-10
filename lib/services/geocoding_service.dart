import 'package:geocoding/geocoding.dart';

class GeocodingService {
  Future<void> getLatLng(String address) async {
    List<Location> locations = await locationFromAddress(address);
    if (locations.isNotEmpty) {
      double latitude = locations[0].latitude;
      double longitude = locations[0].longitude;

      print('Latitude: $latitude');
      print('Longitude: $longitude');
    } else {
      print('Adres bulunamadı');
    }
  }
}

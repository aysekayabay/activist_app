import 'package:geocoding/geocoding.dart';

class GeocodingService {
  Future<Location?> getLatLng(String address) async {
    try {
      List<Location> locations = await locationFromAddress(address);
      if (locations.isNotEmpty) {
        return locations[0];
      } else {
        print('Adres bulunamadı');
        return null;
      }
    } catch (e) {
      print(e.toString());
    } finally {
      return null;
    }
  }
}

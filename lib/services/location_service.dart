import 'package:geolocator/geolocator.dart';

class LocationService {
  Future<Map<String, dynamic>?> getLocation() async {
    final bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return null;
    }

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      return null;
    }

    try {
      final Position position = await Geolocator.getCurrentPosition(
        locationSettings: LocationSettings(accuracy: LocationAccuracy.high),
      );

      return {"latitude": position.latitude, "longitude": position.longitude};
    } catch (e) {
      return null;
    }
  }
}

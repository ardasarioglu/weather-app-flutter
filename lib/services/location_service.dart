import 'package:geolocator/geolocator.dart';

class LocationService {
  Future<Map<String, dynamic>?> getLocation() async {
    final bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      Future.error("Your location service is disabled.");
    }

    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      await Geolocator.requestPermission();
    }

    final Position position = await Geolocator.getCurrentPosition(
      locationSettings: LocationSettings(accuracy: LocationAccuracy.high),
    );

    if (!serviceEnabled) {
      return null;
    }

    return {"latitude": position.latitude, "longitude": position.longitude};
  }
}

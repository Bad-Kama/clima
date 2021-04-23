import 'package:geolocator/geolocator.dart';

class Location {
  Location();
  double latitude;
  double longitude;

  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);
      // print(position);
      latitude = position.latitude;
      longitude = position.longitude;
    } catch (e) {
      print(e);
    }
  }
}

/// if a function does not return future, you can't call await on it
/// to call await within a function, that function needs to be async

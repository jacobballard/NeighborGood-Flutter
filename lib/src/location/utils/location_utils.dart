import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<GeoPoint> getStoredLocation() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  double? latitude = prefs.getDouble('latitude');
  double? longitude = prefs.getDouble('longitude');

  if (latitude != null && longitude != null) {
    return GeoPoint(latitude, longitude);
  } else {
    // Return a default location if no location data is available
    return const GeoPoint(0, 0);
  }
}

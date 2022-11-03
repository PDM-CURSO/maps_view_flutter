import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapaProvider with ChangeNotifier {
  // 0)
  Set<Marker> mapMarkers = Set();
  GoogleMapController? mapController;
  Position? currentPosition = Position(
    longitude: 20.608148,
    latitude: -103.417576,
    altitude: 0.0,
    speed: 0.0,
    accuracy: 0.0,
    speedAccuracy: 0.0,
    timestamp: DateTime.now(),
    heading: 0.0,
  );

  // 2)
  Future<void> onMapCreated(controller) async {
    // TODO: assign controller
  }

  // 4)
  void setMarker(LatLng coord) async {
    // TODO: get address using LatLng

    // TODO: add my  marker
  }

  // 3)
  Future<void> getCurrentPosition() async {
    // TODO: verify location permissions

    // TODO: get current position

    // TODO: get address using current user's position

    // TODO: add a marker on the map view

    // TODO: move camera to the current user's location
  }

  // 5)
  Future<String> _getGeocodingAddress(Position position) async {
    // TODO: inverted geocoding to get text address
    return "";
  }
}

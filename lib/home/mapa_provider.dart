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
    // assign controller
    mapController = controller;
    await getCurrentPosition();
    notifyListeners();
  }

  // 4)
  void setMarker(LatLng coord) async {
    // get address using LatLng
    String _markerAddress = await _getGeocodingAddress(
      Position(
        longitude: coord.latitude,
        latitude: coord.longitude,
        altitude: 0.0,
        speed: 0.0,
        accuracy: 0.0,
        speedAccuracy: 0.0,
        timestamp: DateTime.now(),
        heading: 0.0,
      ),
    );
    //  add my  marker
    mapMarkers.add(
      Marker(
        markerId: MarkerId(
          coord.toString(),
        ),
        position: coord,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        infoWindow: InfoWindow(
          title: coord.toString(),
          snippet: _markerAddress,
        ),
      ),
    );
    notifyListeners();
  }

  // 3)
  Future<void> getCurrentPosition() async {
    // verify location permissions
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
    }
    // get current position
    currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    // get address using current user's position
    String _currentAddress = await _getGeocodingAddress(currentPosition!);
    // add a marker on the map view
    mapMarkers.add(
      Marker(
        markerId: MarkerId(
          currentPosition.toString(),
        ),
        position: LatLng(
          currentPosition!.latitude,
          currentPosition!.longitude,
        ),
        infoWindow: InfoWindow(
          title: currentPosition.toString(),
          snippet: _currentAddress,
        ),
      ),
    );

    //  move camera to the current user's location
    mapController!.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(
            currentPosition!.latitude,
            currentPosition!.longitude,
          ),
          zoom: 15,
        ),
      ),
    );
  }

  // 5)
  Future<String> _getGeocodingAddress(Position position) async {
    // inverted geocoding to get text address
    var places = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );
    if (places != null && places.isNotEmpty) {
      final Placemark place = places.first;
      return "${place.thoroughfare}, ${place.locality}";
    }
    return "No address available";
  }
}

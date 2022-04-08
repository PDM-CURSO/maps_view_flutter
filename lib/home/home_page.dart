import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_view/home/mapa_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MapaProvider>(
      builder: (context, provider, child) => GoogleMap(
        onMapCreated: provider.onMapCreated,
        onLongPress: provider.setMarker,
        markers: provider.mapMarkers,
        initialCameraPosition: CameraPosition(
          target: LatLng(
            provider.currentPosition!.latitude,
            provider.currentPosition!.longitude,
          ),
        ),
      ),
    );
  }
}

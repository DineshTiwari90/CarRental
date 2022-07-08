import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CreateMap extends StatefulWidget {
  const CreateMap({Key? key}) : super(key: key);

  @override
  State<CreateMap> createState() => _CreateMapState();
}

class _CreateMapState extends State<CreateMap> {
  static const _initalCameraPosition = CameraPosition(
      target: LatLng(
        37.773972,
        -122.431297,
      ),
      zoom: 11.5);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
          initialCameraPosition: _initalCameraPosition),
    );
  }
}

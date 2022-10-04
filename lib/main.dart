import 'package:flutter/material.dart';
import 'package:google_maps_course/pages/home.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(const MyApp());
}

/// Maps Is exist on Google Cloud Server

/// API Key is a way to google maps authenticate
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(31.205753, 29.924526),
          zoom: 19,
        ),
      ),
    );
  }
}

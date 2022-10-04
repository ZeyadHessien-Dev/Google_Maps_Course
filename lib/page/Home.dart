import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Google Map'),
      ),
      body: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          const GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(
                31.205753,
                29.924526,
              ),
              zoom: 19,
            ),
          ),
          Image.asset(
            'assets/images/c2s.png',
          ),
        ],
      ),
    );
  }
}

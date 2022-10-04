import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var markers = HashSet<Marker>();

  /// Collection Contain On Marker
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Google Map'),
      ),
      body: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          GoogleMap(
            initialCameraPosition: const CameraPosition(
              target: LatLng(
                31.205753,
                29.924526,
              ),
              zoom: 19,
            ),
            onMapCreated: (GoogleMapController controller) {
              setState(
                () {
                  markers.add(
                    const Marker(
                      markerId: MarkerId('1'),
                      position: LatLng (
                        31.205753,
                        29.924526,
                      ),
                    ),
                  );
                },
              );
            },
            markers: markers,
          ),
          Image.asset(
            'assets/images/c2s.png',
          ),
        ],
      ),
    );
  }
}

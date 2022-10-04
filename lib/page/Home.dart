import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var markers = HashSet<Marker>();
  BitmapDescriptor? customMarker;

  getCustomMarker() async {
    customMarker = await BitmapDescriptor.fromAssetImage(
      /// Configuration --> Additional Image
      ImageConfiguration.empty,
      "assets/images/cc2s.png",
    );
  }

  @override
  void initState() {
    getCustomMarker();
    super.initState();
  }

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
                    Marker(
                      markerId: const MarkerId('1'),
                      position: const LatLng(
                        31.205753,
                        29.924526,
                      ),
                      infoWindow: const InfoWindow(
                        title: 'Learn Google Maps',
                        snippet: 'Please Learn Code Well',
                      ),
                      onTap: () {
                        /// May be go to another page, send thing to API
                        print("Marker Tap");
                      },
                      icon: customMarker!,
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

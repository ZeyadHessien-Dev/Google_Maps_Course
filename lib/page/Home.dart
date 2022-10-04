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

  Set<Polygon> myPolygon() {
    List<LatLng> polygonCoords = [
      const LatLng(37.43296265331129, -122.08832357078792),
      const LatLng(37.43006265331129, -122.08832357078792),
      const LatLng(37.43006265331129, -122.08332357078792),
      const LatLng(37.43296265331129, -122.08832357078792),
    ];

    Set<Polygon> polygonSet = <Polygon>{};
    polygonSet.add(
      Polygon( /// Indicate Google Map Package
        polygonId: const PolygonId('1'),
        points: polygonCoords,
        strokeWidth: 5,
        fillColor: Colors.white,
        strokeColor: Colors.red,
      ),
    );
    return polygonSet;
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
                37.43296265331129,
                -122.08832357078792,
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
            
                      ),
                      onTap: () {
                          /// May be go to another page, send thing to API
                          print("Marker Tap");
                        },
                     ),
                  );
                },
              );
            },
            markers: markers,
            polygons: myPolygon(),
          ),
          Image.asset(
            'assets/images/c2s.png',
          ),
        ],
      ),
    );
  }
}

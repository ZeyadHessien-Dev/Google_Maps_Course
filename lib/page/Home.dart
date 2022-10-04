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
    super.initState();
    getCustomMarker();
    createPolyLine();
  }

  createPolyLine() {
    myPolyline.add(
      Polyline(
        polylineId: const PolylineId('1'),
        color: Colors.blue,
        width: 3,
        patterns: [
          PatternItem.dash(
            20.0,
          ),
          PatternItem.gap(
            10,
          ),
        ],
        points: const [
          LatLng(29.990000, 31.149000),
          LatLng(29.999000, 31.149900),
        ],
      ),
    );
  }

  /// Set Like Array [Polygon]
  Set<Polygon> myPolygon = {
    const Polygon(
      polygonId: PolygonId('1'),
      points: [
        LatLng(37.43296265331129, -122.08832357078792),
        LatLng(37.43006265331129, -122.08832357078792),
        LatLng(37.43006265331129, -122.08332357078792),
        LatLng(37.43296265331129, -122.08832357078792),
      ],
      strokeWidth: 5,
      fillColor: Colors.white,
      strokeColor: Colors.red,
    ),
  };

  /// [Circle]
  Set<Circle> myCircles = {
    const Circle(
      circleId: CircleId('1'),
      center: LatLng(29.990940, 31.149248),
      radius: 1000,
      strokeWidth: 2,
      fillColor: Colors.white,
    ),
  };

  /// [Polyline]
  List<Polyline> myPolyline = [];

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
            mapType: MapType.normal,
            // mapType: MapType.hybrid,
            // mapType: MapType.satellite,
            // mapType: MapType.terrain,
            //  mapType: MapType.none,
            initialCameraPosition: const CameraPosition(
              target: LatLng(
                29.990000,
                31.149000,
              ),
              zoom: 14,
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
                      // icon: customMarker!,
                    ),
                  );
                },
              );
            },
            markers: markers,
            polygons: myPolygon,
            circles: myCircles,
            polylines: myPolyline.toSet(),
          ),
          Image.asset(
            'assets/images/c2s.png',
          ),
        ],
      ),
    );
  }
}

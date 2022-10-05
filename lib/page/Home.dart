import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Position? currentLocation;
  CameraPosition? cameraPosition;
  dynamic lat;
  dynamic long;
  Set<Marker>? markers;

  Future getPostion() async {
    bool services;
    services = await Geolocator.isLocationServiceEnabled();
    print(services);
    LocationPermission per;
    per = await Geolocator.checkPermission();
    if (per == LocationPermission.denied) {
      per = await Geolocator.requestPermission();

      /// IF User denied can navigate it to login screen for example by Navigator.Push
      // if (per == LocationPermission.whileInUse) {
      //   getLatAndLog();
      // }
    }
    print("====================================");
    print(per);
    print("====================================");
    getLatAndLog();
    return per;
  }

  void getLatAndLog() async {
    currentLocation =
        await Geolocator.getCurrentPosition().then((value) => value);
    lat = currentLocation!.latitude;
    long = currentLocation!.longitude;
    cameraPosition = CameraPosition(
      target: LatLng(lat, long),
      zoom: 14.4746,
    );
    markers = {
      Marker(
        markerId: const MarkerId('1'),
        position: LatLng(lat, long),
        infoWindow: InfoWindow(
          title: 'One',
          onTap: () {
            print("One");
          },
        ),
        onTap: () {
          print("Tap Info Marker");
        },
        draggable: true,
        onDragEnd: (LatLng t) {
          print("On Drag End $t");
        },

        /// Can Do It With assetImage Like Following
        //  BitmapDescriptor.fromAssetImage(
        //       ImageConfiguration.empty,
        //       "assets/images/cc2s.png",
        //     );
        icon: BitmapDescriptor.defaultMarkerWithHue(
          BitmapDescriptor.hueCyan,
        ),
      ),
    };
    setState(() {});
  }

  @override
  initState() {
    getPostion();
    super.initState();
  }

  GoogleMapController? gmc;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Google Map'),
      ),
      body: Column(
        children: [
          cameraPosition == null || markers == null
              ? const Center(child: CircularProgressIndicator())
              : SizedBox(
                  height: 500,
                  child: GoogleMap(
                    onTap: (LatLng latLng) {
                      markers!.remove(
                        const Marker(
                          markerId: MarkerId('1'),
                        ),
                      );
                      markers!.add(
                        Marker(
                          markerId: const MarkerId('1'),
                          position: latLng,
                        ),
                      );
                      setState(() {});
                    },
                    mapType: MapType.normal,
                    initialCameraPosition: cameraPosition!,
                    onMapCreated: (GoogleMapController controller) {
                      gmc = controller;
                    },
                    markers: markers!,
                  ),
                ),
          const SizedBox(
            height: 20,
          ),
          MaterialButton(
            color: Colors.blue,
            onPressed: () {
              LatLng latLng = const LatLng(
                21.422390,
                39.722958,
              );

              /// Can Use MoveCamera Instead AnimateCamera
              gmc!.animateCamera(
                // CameraUpdate.newLatLng(
                //   latLng,
                // ),
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: latLng,
                    zoom: 8,
                  ),
                ),
              );
            },
            child: const Text(
              'Go To Maka',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          MaterialButton(
            color: Colors.red,
            onPressed: () async {
              var xy = await gmc!.getLatLng(
                const ScreenCoordinate(x: 200, y: 200),
              );
              print('Current Coordinates On Map Is $xy');
            },
            child: const Text(
              'Show LatLng',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          MaterialButton(
            color: Colors.amber,
            onPressed: () async {
              var xy = await gmc!.getZoomLevel();
              print('Current Zoom $xy');
            },
            child: const Text(
              'Show LatLng',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

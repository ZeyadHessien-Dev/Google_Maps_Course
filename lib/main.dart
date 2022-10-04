import 'package:flutter/material.dart';
import 'package:google_maps_course/page/Home.dart';

void main() {
  runApp(const MyApp());
}

/// Maps Is exist on Google Cloud Server
/// API Key is a way to google maps authenticate
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
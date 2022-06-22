import 'dart:async';
import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gps_tracker/geolocator/geolocator_page.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Gps Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const GeolocatorPage(title: 'Flutter Gps Tracker'),
    );
  }
}
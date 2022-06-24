import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gps_tracker/screen/geolocator/geolocator_page.dart';
import 'package:gps_tracker/screen/location/location_page.dart';
import 'package:gps_tracker/screen/open_street_maps/open_street_maps_screen.dart';
import 'package:gps_tracker/screen/syncfusion_maps_shape_layer/syncfusion_maps_screen.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyApp(),
    ));

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  onButtonTap(Widget page) {
    Navigator.push(
        context, MaterialPageRoute(builder: (BuildContext context) => page));
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter GPS Tracker"),
      ),
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: ListView(
          children: <Widget>[
            MyMenuButton(
              title: "GPS with Geolocator",
              actionTap: () {
                onButtonTap(
                  const GeolocatorPage(title: 'GPS with Geolocator'),
                );
              },
            ),
            MyMenuButton(
              title: "GPS with Location",
              actionTap: () {
                onButtonTap(
                  LocationPage(title: "GPS with Location"),
                );
              },
            ),
            MyMenuButton(
              title: "Open Street Maps",
              actionTap: () {
                onButtonTap(
                  OpenStreetMapsScreen(),
                );
              },
            ),
            MyMenuButton(
              title: "Syncfusion Maps Shape Layer",
              actionTap: () {
                onButtonTap(
                  SyncfusionMapsScreen(
                    title: "Syncfusion Maps Shape Layer",
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class MyMenuButton extends StatelessWidget {
  final String? title;
  final VoidCallback? actionTap;

  MyMenuButton({this.title, this.actionTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: MaterialButton(
        height: 50.0,
        color: Theme.of(context).primaryColor,
        textColor: Colors.white,
        child: new Text(title!),
        onPressed: actionTap,
      ),
    );
  }
}

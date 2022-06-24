import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class OpenStreetMapsScreen extends StatefulWidget {
  OpenStreetMapsScreen({Key? key}) : super(key: key);

  @override
  State<OpenStreetMapsScreen> createState() => _OpenStreetMapsScreenState();
}

class _OpenStreetMapsScreenState extends State<OpenStreetMapsScreen> {
  LatLng sourceLocation = LatLng(-7.077335, 110.423378);
  LatLng VF = LatLng(-7.07740, 110.42544);
  LatLng destination = LatLng(-6.99, 110.42);
  // -7.077308260384515, 110.42561579451761

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Open Street Maps",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
      body: FlutterMap(
        options: MapOptions(
          center: VF,
          zoom: 16.5,
        ),
        layers: [
          TileLayerOptions(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],
          ),
          MarkerLayerOptions(
            markers: [
              Marker(
                width: 80.0,
                height: 80.0,
                point: VF,
                builder: (ctx) => Container(
                  child: Image.asset("assets/icons/marker.png"),
                ),
              ),
            ],
          ),
        ],
        nonRotatedChildren: [
          AttributionWidget.defaultWidget(
            source: 'OpenStreetMap contributors',
            onSourceTapped: () {},
          ),
        ],
      ),
    );
  }
}

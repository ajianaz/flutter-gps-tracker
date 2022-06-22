import 'package:flutter/material.dart';
import 'package:location/location.dart';

enum _PositionItemType {
  log,
  position,
}

class _PositionItem {
  _PositionItem(this.type, this.displayValue);

  final _PositionItemType type;
  final String displayValue;
}

//Location - pub dev
// class LocationData {
//   final double latitude; // Latitude, in degrees
//   final double longitude; // Longitude, in degrees
//   final double accuracy; // Estimated horizontal accuracy of this location, radial, in meters
//   final double altitude; // In meters above the WGS 84 reference ellipsoid
//   final double speed; // In meters/second
//   final double speedAccuracy; // In meters/second, always 0 on iOS
//   final double heading; // Heading is the horizontal direction of travel of this device, in degrees
//   final double time; // timestamp of the LocationData
//   final bool isMock; // Is the location currently mocked
// }

// enum LocationAccuracy {
//   powerSave, // To request best accuracy possible with zero additional power consumption,
//   low, // To request "city" level accuracy
//   balanced, // To request "block" level accuracy
//   high, // To request the most accurate locations available
//   navigation // To request location for navigation usage (affect only iOS)
// }

// Status of a permission request to use location services.
// enum PermissionStatus {
//   /// The permission to use location services has been granted.
//   granted,
//   // The permission to use location services has been denied by the user. May have been denied forever on iOS.
//   denied,
//   // The permission to use location services has been denied forever by the user. No dialog will be displayed on permission request.
//   deniedForever
// }

class LocationPage extends StatefulWidget {
  LocationPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  static const String _kLocationServicesDisabledMessage =
      'Location services are disabled.';
  static const String _kPermissionDeniedMessage = 'Permission denied.';
  static const String _kPermissionDeniedForeverMessage =
      'Permission denied forever.';
  static const String _kPermissionGrantedMessage = 'Permission granted.';

  final List<_PositionItem> _positionItems = <_PositionItem>[];

  Location location = new Location();
  LocationData? _locationData;
  bool? _serviceEnabled;
  PermissionStatus? _permissionGranted;

  @override
  Widget build(BuildContext context) {
    const sizedBox = SizedBox(
      height: 10,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: _positionItems.length,
        itemBuilder: (context, index) {
          final positionItem = _positionItems[index];

          if (positionItem.type == _PositionItemType.log) {
            return ListTile(
              title: Text(positionItem.displayValue,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  )),
            );
          } else {
            return Card(
              child: ListTile(
                tileColor: Colors.blue,
                title: Text(
                  positionItem.displayValue,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            );
          }
        },
      ),
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            child: const Icon(Icons.my_location),
            onPressed: _getCurrentPosition,
          ),
        ],
      ),
    );
  }

  void _updatePositionList(_PositionItemType type, String displayValue) {
    _positionItems.add(_PositionItem(type, displayValue));
    setState(() {});
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handlePermission();

    if (!hasPermission) {
      return;
    }

    final _locationData = await location.getLocation();
    _updatePositionList(
      _PositionItemType.position,
      _locationData.toString(),
    );
  }

  Future<bool> _handlePermission() async {
    // Test if location services are enabled.
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled!) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled!) {
        return false;
      }
    }

    // Test if location services are enabled.
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled!) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      _updatePositionList(
        _PositionItemType.log,
        _kLocationServicesDisabledMessage,
      );

      return false;
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        _updatePositionList(
          _PositionItemType.log,
          _kPermissionDeniedMessage,
        );

        return false;
      }
    }

    if (_permissionGranted == PermissionStatus.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      _updatePositionList(
        _PositionItemType.log,
        _kPermissionDeniedForeverMessage,
      );

      return false;
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    _updatePositionList(
      _PositionItemType.log,
      _kPermissionGrantedMessage,
    );
    return true;
  }
}

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dialogs.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _mapController;
  Position? _selectedLocation;

  void _getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are disabled, show a dialog or snackbar to enable it
      return;
    }
    // Check if the app has permission to access the location
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // Location permissions are denied, ask for permission
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are still denied, show a dialog or snackbar to inform the user
        final permissionGranted = await showPermissionDialog(
          context,
          'Please grant access to your location',
        );
        if (permissionGranted) {
          _getLocation();
        } else {
          return;
        }
        return;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return;
    }
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      {
        _selectedLocation = position;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Your Location'),
      ),
      body: Center(
        child: Column(
          children: [Text("location  : $_selectedLocation")],
        ),
      ),
      // GoogleMap(
      //   onMapCreated: (controller) {
      //     setState(() {
      //       _mapController = controller;
      //     });
      //   },
      //   initialCameraPosition: const CameraPosition(
      //     target: LatLng(0, 0),
      //     zoom: 15.0,
      //   ),
      //   markers: _selectedLocation != null
      //       ? <Marker>{
      //           Marker(
      //             markerId: const MarkerId('selectedLocation'),
      //             position: LatLng(
      //               _selectedLocation!.latitude,
      //               _selectedLocation!.longitude,
      //             ),
      //           ),
      //         }
      //       : <Marker>{},
      // ),
      floatingActionButton: Stack(children: [
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16.0, right: 16.0),
            child: IconButton(
              color: Colors.red,
              onPressed: () {
                _getLocation();
              },
              icon: const Icon(Icons.location_city),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 90.0, right: 16.0),
            child: IconButton(
              color: Colors.green,
              onPressed: () {
                //   Handle the selection of the location
                //   pass it back to the previous screen or perform any other logic
                Navigator.pop(context, _selectedLocation);
              },
              icon: const Icon(Icons.check),
            ),
          ),
        ),
      ]),
    );
  }
}

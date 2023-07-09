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
    // print('get location ');
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      final permissionGranted = await showPermissionDialog(
        context,
        'Please grant access to your location',
      );
      if (permissionGranted) {
        _getLocation();
      } else {
        Navigator.of(context).pop();
      }
    } else if (permission == LocationPermission.deniedForever) {
      // Handle permanently denied permission
    } else {
      // Permission granted, proceed to get the current location
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      setState(() {
        _selectedLocation = position;
      });
      // Use the obtained position to update the map or perform any other necessary actions
    }
  }

  @override
  void initState() {
    // _selectedLocation = Position.fromMap({
    //   'latitude': 0,
    //   'longitude': 0,
    //   'timestamp': DateTime.now(),
    //   'accuracy': 0,
    //   'altitude': 0,
    //   'heading': 0,
    //   'speed': 0,
    //   'speed_accuracy': 0,
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Your Location'),
      ),
      body: GoogleMap(
        onMapCreated: (controller) {
          setState(() {
            _mapController = controller;
          });
        },
        initialCameraPosition: const CameraPosition(
          target: LatLng(0, 0),
          zoom: 15.0,
        ),
        markers: _selectedLocation != null
            ? <Marker>{
                Marker(
                  markerId: const MarkerId('selectedLocation'),
                  position: LatLng(
                    _selectedLocation!.latitude,
                    _selectedLocation!.longitude,
                  ),
                ),
              }
            : <Marker>{},
      ),
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

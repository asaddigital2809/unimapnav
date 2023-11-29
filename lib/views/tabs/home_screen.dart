import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GoogleMapController? googleMapController;
  Set<Marker> markers = {};
  LatLng initialPosition = const LatLng(45.521563, -122.677433); // Default position

  Future<void> onMapCreated(GoogleMapController controller) async {
    googleMapController = controller;
  }

  Future<void> getCurrentLocation() async {
    PermissionStatus permission = await Permission.location.request();
    if (permission.isGranted) {
      final geoposition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      final position = LatLng(geoposition.latitude, geoposition.longitude);
      setState(() {
        initialPosition = position; // Update initial position
        markers.add(Marker(markerId: const MarkerId('1'), position: position, infoWindow: const InfoWindow(title: 'Your Location')));
      });

      setState(() {
        googleMapController?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          target: position,
          zoom: 11.0,
        )));
      });
    } else {
      // Handle permission denied case
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: GoogleMap(
          myLocationEnabled: true,
          markers: markers,
          onMapCreated: onMapCreated,
          initialCameraPosition: CameraPosition(
            target: initialPosition,
            zoom: 11.0,
          ),
        ),
      ),
    );
  }
}

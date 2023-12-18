import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:unimapnav/model/location_model.dart';

class MyMapController extends GetxController {
  bool mapLoading = false;
  @override
  void onInit() {
    getCurrentLocation();
    getAllLocation();
    super.onInit();
  }

  LocationModel locationModel = LocationModel();
  List<LocationModel> locationList = [];

  getAllLocation() async {
    await FirebaseFirestore.instance
        .collection("locations")
        .get()
        .then((value) {
      for (int i = 0; i < value.docs.length; i++) {
        locationModel = LocationModel.fromJson(value.docs[i].data());
        locationList.add(locationModel);
      }
      update();
    });
    locationList.forEach((element) {
      markers.add(Marker(
          markerId: MarkerId(element.name.toString()),
          icon: element.ground == 'G'
              ? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure)
              : BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueOrange),
          position: LatLng(element.points!.latitude, element.points!.longitude),
          infoWindow: InfoWindow(
            title: element.name,
            snippet:
                "Floor: ${element.ground}:${element.forDisabled! ? "Disabled people can use this way" : "Disabled people cannot use this way"}",
          )));
    });
  }

  GoogleMapController? googleMapController;
  Set<Marker> markers = {};
  LatLng initialPosition =
      const LatLng(45.521563, -122.677433); // Default position

  Future<void> onMapCreated(GoogleMapController controller) async {
    googleMapController = controller;
  }

  Future<void> getCurrentLocation() async {
    mapLoading = true;
    update();
    PermissionStatus permission = await Permission.location.request();
    if (permission.isGranted) {
      final geoposition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      final position = LatLng(geoposition.latitude, geoposition.longitude);
      initialPosition = position; // Update initial position
      markers.add(Marker(
          markerId: const MarkerId('1'),
          position: position,
          infoWindow: const InfoWindow(title: 'Your Location')));

      googleMapController
          ?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: position,
        zoom: 11.0,
      )));
      mapLoading = false;
      update();
    } else {
      // Handle permission denied case
    }
  }
}

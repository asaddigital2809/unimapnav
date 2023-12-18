import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../controllers/map_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  MyMapController myMapController = Get.put(MyMapController());


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<MyMapController>(
        init: myMapController,
        builder: (controller) => GoogleMap(
          onMapCreated: controller.onMapCreated,
          initialCameraPosition: CameraPosition(
            target: controller.initialPosition,
            zoom: 11.0,
          ),
          markers: controller.markers,
        ),)
    );
  }
}

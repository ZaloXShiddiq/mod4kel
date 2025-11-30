import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../controllers/gps_location_controller.dart';

/// Displays the current GPS location using a map.  Allows the
/// user to refresh the reading manually via a button.
class GpsLocationView extends GetView<GpsLocationController> {
  const GpsLocationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('GPS Location')),
      body: Obx(() {
        final pos = controller.position.value;
        final center = pos != null
            ? LatLng(pos.latitude, pos.longitude)
            : const LatLng(0, 0);
        return FlutterMap(
          options: MapOptions(
            center: center,
            zoom: 16.0,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.example.modul4kel',
            ),
            if (pos != null)
              MarkerLayer(markers: [
                Marker(
                  width: 40,
                  height: 40,
                  point: center,
                  builder: (context) => const Icon(
                    Icons.my_location,
                    color: Colors.blue,
                    size: 40,
                  ),
                ),
              ]),
          ],
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.fetchCurrentPosition,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
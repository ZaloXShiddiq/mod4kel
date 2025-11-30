import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../controllers/network_location_controller.dart';

/// View that displays the current network-based location on an
/// OpenStreetMap using `flutter_map`.  A refresh button allows
/// the user to fetch a new position on demand.
class NetworkLocationView extends GetView<NetworkLocationController> {
  const NetworkLocationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Network Location')),
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
                    Icons.location_on,
                    color: Colors.red,
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
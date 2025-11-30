import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../controllers/live_location_controller.dart';

/// A view that tracks and displays the user's movement in real time.
///
/// As the controller emits new [Position] values, the marker and
/// map center will update automatically thanks to the use of
/// `Obx`.  The map uses OpenStreetMap tiles via `flutter_map`.
class LiveLocationView extends GetView<LiveLocationController> {
  const LiveLocationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Live Location')),
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
                    Icons.directions_walk,
                    color: Colors.green,
                    size: 40,
                  ),
                ),
              ]),
          ],
        );
      }),
    );
  }
}
import 'dart:async';

import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../services/location_service.dart';

/// Controller that listens to continuous location updates and exposes
/// them reactively.  Used for the live location screen.
class LiveLocationController extends GetxController {
  LiveLocationController(this._locationService);

  final LocationService _locationService;
  final Rxn<Position> position = Rxn<Position>();
  StreamSubscription<Position>? _subscription;

  @override
  void onInit() {
    super.onInit();
    _subscribeToLocation();
  }

  void _subscribeToLocation() async {
    // Listen for real-time updates with best accuracy.  A small
    // distance filter reduces noisy updates when the device is
    // stationary but can be tuned as needed.  Here we set it to
    // 5 meters.
    _subscription = _locationService
        .getPositionStream(accuracy: LocationAccuracy.best, distanceFilter: 5)
        .listen((pos) {
      position.value = pos;
    });
  }

  @override
  void onClose() {
    _subscription?.cancel();
    super.onClose();
  }
}
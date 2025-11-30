import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../services/location_service.dart';

/// Controller responsible for retrieving the device's position
/// using the network provider.  It interacts with
/// [LocationService] to request location updates with low
/// accuracy.  The current position is exposed as a reactive
/// [Rxn] so that the view can listen and update automatically.
class NetworkLocationController extends GetxController {
  NetworkLocationController(this._locationService);

  final LocationService _locationService;

  /// The most recent position reported by the network provider.
  final Rxn<Position> position = Rxn<Position>();

  /// Obtain the current position once using network accuracy.
  Future<void> fetchCurrentPosition() async {
    final pos = await _locationService.getCurrentPosition(
      accuracy: LocationAccuracy.low,
    );
    if (pos != null) {
      position.value = pos;
    }
  }

  @override
  void onInit() {
    super.onInit();
    // Preload a position when the controller is created.
    fetchCurrentPosition();
  }
}
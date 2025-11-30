import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../services/location_service.dart';

/// Controller responsible for retrieving GPS-based positions.
///
/// Uses [LocationService] with high accuracy to obtain the
/// current location.  The position is stored in a reactive
/// variable so the UI can respond automatically to changes.
class GpsLocationController extends GetxController {
  GpsLocationController(this._locationService);

  final LocationService _locationService;
  final Rxn<Position> position = Rxn<Position>();

  /// Fetch a single GPS position using high accuracy.
  Future<void> fetchCurrentPosition() async {
    final pos = await _locationService.getCurrentPosition(
      accuracy: LocationAccuracy.high,
    );
    if (pos != null) {
      position.value = pos;
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchCurrentPosition();
  }
}
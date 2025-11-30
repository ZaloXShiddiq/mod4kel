import 'package:get/get.dart';

import '../controllers/gps_location_controller.dart';
import '../../../../services/location_service.dart';

/// Binding class for the GPS location screen.
///
/// Registers dependencies needed for GPS location retrieval.
class GpsLocationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LocationService>(() => LocationService());
    Get.lazyPut<GpsLocationController>(
      () => GpsLocationController(Get.find()),
    );
  }
}
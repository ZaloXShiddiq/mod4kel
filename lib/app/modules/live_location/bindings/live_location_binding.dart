import 'package:get/get.dart';

import '../controllers/live_location_controller.dart';
import '../../../../services/location_service.dart';

/// Binding for the live (real-time) location screen.
class LiveLocationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LocationService>(() => LocationService());
    Get.lazyPut<LiveLocationController>(
      () => LiveLocationController(Get.find()),
    );
  }
}
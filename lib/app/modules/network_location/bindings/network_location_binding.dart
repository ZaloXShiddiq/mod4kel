import 'package:get/get.dart';

import '../controllers/network_location_controller.dart';
import '../../../../services/location_service.dart';

/// Binding class for the network location screen.
///
/// This binding registers the [LocationService] and
/// [NetworkLocationController] so that they can be injected
/// automatically when the corresponding view is navigated to.
class NetworkLocationBinding extends Bindings {
  @override
  void dependencies() {
    // Provide a single instance of LocationService for the network
    // location module.  If another binding has already
    // registered this service, GetX will reuse it.
    Get.lazyPut<LocationService>(() => LocationService());
    Get.lazyPut<NetworkLocationController>(
      () => NetworkLocationController(Get.find()),
    );
  }
}
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

/// Binding for the home module.  Lazily instantiates a
/// [HomeController] when the home route is first navigated to.
class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
  }
}
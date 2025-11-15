import 'package:get/get.dart';

import '../controllers/register_controller.dart';

/// Binding to lazily instantiate a [RegisterController] when the
/// registration module is used.
class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterController>(() => RegisterController());
  }
}
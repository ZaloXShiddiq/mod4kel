import 'package:get/get.dart';

import '../controllers/auth_controller.dart';

/// Binding to lazily provide an instance of [AuthController] when the
/// authentication module is first accessed.  This ensures the controller
/// remains in memory only as long as it is needed.
class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthController>(() => AuthController());
  }
}
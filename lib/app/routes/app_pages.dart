import 'package:get/get.dart';

import '../modules/about/bindings/about_binding.dart';
import '../modules/about/views/about_view.dart';
import '../modules/auth/bindings/auth_binding.dart';
import '../modules/auth/views/auth_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
// Location‑aware module imports (Modul 5)
import '../modules/gps_location/bindings/gps_location_binding.dart';
import '../modules/gps_location/views/gps_location_view.dart';
import '../modules/network_location/bindings/network_location_binding.dart';
import '../modules/network_location/views/network_location_view.dart';
import '../modules/live_location/bindings/live_location_binding.dart';
import '../modules/live_location/views/live_location_view.dart';
import 'app_routes.dart';

//

/// Defines all routes used in the application along with the
/// corresponding page and binding.  GetX uses this list to
/// instantiate controllers and display views when navigating.
class AppPages {
  /// List of routes used throughout the application.  The ordering
  /// here determines the order of route resolution when multiple
  /// definitions share the same name.  Each [GetPage] specifies a
  /// unique route name, the view to display, and the binding
  /// responsible for instantiating controllers.
  static final routes = <GetPage<dynamic>>[
    GetPage(
      name: AppRoutes.login,
      page: () => const AuthView(),
      binding: AuthBinding(),
    ),
    // Registration page
    GetPage(
      name: AppRoutes.register,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.about,
      page: () => const AboutView(),
      binding: AboutBinding(),
    ),
    // Location‑aware pages (Modul 5)
    GetPage(
      name: AppRoutes.networkLocation,
      page: () => const NetworkLocationView(),
      binding: NetworkLocationBinding(),
    ),
    GetPage(
      name: AppRoutes.gpsLocation,
      page: () => const GpsLocationView(),
      binding: GpsLocationBinding(),
    ),
    GetPage(
      name: AppRoutes.liveLocation,
      page: () => const LiveLocationView(),
      binding: LiveLocationBinding(),
    ),
  ];
}
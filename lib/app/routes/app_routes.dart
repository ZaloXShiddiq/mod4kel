/// Defines named routes for the application.  Keeping these constants
/// in a single place helps avoid typos and makes refactoring easier.
class AppRoutes {
  /// Route name for the login page.
  static const String login = '/login';

  /// Route name for the home page.  This page shows the catalogue.
  static const String home = '/home';

  /// Route name for the about page.
  static const String about = '/about';

  /// Route name for the register page.
  static const String register = '/register';

  /// Route name for the GPS location page (Modul 5).
  ///
  /// This route displays a static GPS reading using high accuracy.
  static const String gpsLocation = '/gps-location';

  /// Route name for the network location page (Modul 5).
  ///
  /// This route obtains location estimates using lower accuracy (cellular
  /// or Wi‑Fi networks).
  static const String networkLocation = '/network-location';

  /// Route name for the live location page (Modul 5).
  ///
  /// This route subscribes to a stream of location updates, showing
  /// positions in real time on a map.
  static const String liveLocation = '/live-location';
}
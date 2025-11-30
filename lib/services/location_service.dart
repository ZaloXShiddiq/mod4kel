import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

/// A service that encapsulates location and permission handling.
///
/// This service centralizes all interactions with the `geolocator`
/// plugin as well as permission checking via `permission_handler`.
/// By isolating this logic from UI code, controllers and views
/// remain testable and focused on presentation.  The methods
/// defined here return either a [Position] or a stream of positions
/// depending on the use case.
class LocationService {
  /// Retrieve the current position of the device once.
  ///
  /// The [accuracy] parameter determines the desired accuracy of
  /// the location data.  For GPS readings use
  /// [LocationAccuracy.high], while for network based readings
  /// [LocationAccuracy.low] may be sufficient.  If the user has
  /// not yet granted location permission, it will be requested.
  Future<Position?> getCurrentPosition({
    LocationAccuracy accuracy = LocationAccuracy.high,
  }) async {
    final permission = await _ensurePermission();
    if (!permission) return null;
    return Geolocator.getCurrentPosition(desiredAccuracy: accuracy);
  }

  /// Subscribe to continuous location updates.
  ///
  /// Returns a [Stream] that emits positions as the device
  /// location changes.  The [accuracy] parameter behaves like
  /// [getCurrentPosition], while [distanceFilter] controls the
  /// minimum distance (in meters) the device must move before a
  /// new position is emitted.  If permission has not been granted
  /// this method requests it first.  When permission is denied the
  /// returned stream will be empty.
  Stream<Position> getPositionStream({
    LocationAccuracy accuracy = LocationAccuracy.high,
    int distanceFilter = 0,
  }) async* {
    final permission = await _ensurePermission();
    if (!permission) {
      yield* const Stream.empty();
      return;
    }
    final settings = LocationSettings(
      accuracy: accuracy,
      distanceFilter: distanceFilter,
    );
    yield* Geolocator.getPositionStream(locationSettings: settings);
  }

  /// Ensure that the application has location permission.
  ///
  /// Returns `true` if permission is granted and `false`
  /// otherwise.  If the permission is denied permanently the user
  /// will need to enable it manually in their system settings.
  Future<bool> _ensurePermission() async {
    var status = await Permission.location.status;
    if (status.isDenied || status.isRestricted) {
      status = await Permission.location.request();
    }
    return status.isGranted;
  }
}
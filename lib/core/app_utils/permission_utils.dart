import 'package:permission_handler/permission_handler.dart';

class PermissionUtils {
  static final _location = Permission.locationWhenInUse;

  static Future<bool> isLocationPermissionGranted() async {
    bool isGranted = await _location.isGranted;
    return isGranted;
  }

  static Future<bool> requestLocationPermission() async {
    if (await _location.isGranted) {
      return true;
    }

    if (await _location.isPermanentlyDenied) {
      openAppSettings();
    }

    if (await _location.isDenied) {
      final result = await _location.request();
      return result.isGranted;
    }

    return false;
  }
}

// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// class AttendanceProvider extends ChangeNotifier {
//   String? checkInTime;
//   String? checkOutTime;
//   bool isCheckedIn = false;
//   bool isOnsite = true; // <-- default

//   void setWorkMode(bool onsite) {
//     isOnsite = onsite;
//     notifyListeners();
//   }

//   void checkIn() {
//     checkInTime = DateFormat('hh:mm a').format(DateTime.now());
//     isCheckedIn = true;
//     notifyListeners();
//   }

//   void checkOut() {
//     checkOutTime = DateFormat('hh:mm a').format(DateTime.now());
//     isCheckedIn = false;
//     notifyListeners();
//   }
// }
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:network_info_plus/network_info_plus.dart';

class AttendanceProvider extends ChangeNotifier {
  String? checkInTime;
  String? checkOutTime;
  bool isCheckedIn = false;
  bool isOnsite = true;

  String? location;
  String? deviceIp;

  /// Set work mode (onsite / remote)
  void setWorkMode(bool onsite) {
    isOnsite = onsite;
    notifyListeners();
  }

  Future<String> _getLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) return "Location Disabled";

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return "Permission Denied";
        }
      }
      if (permission == LocationPermission.deniedForever) {
        return "Permission Permanently Denied";
      }

      // Get coordinates
      Position pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // Reverse geocoding to get address
      List<Placemark> placemarks = await placemarkFromCoordinates(
        pos.latitude,
        pos.longitude,
      );

      if (placemarks.isNotEmpty) {
        final p = placemarks.first;
        return "${p.locality},${p.administrativeArea}";
      } else {
        return "${pos.latitude}, ${pos.longitude}";
      }
    } catch (e) {
      return "Location Error";
    }
  }

  /// Fetch local device IP
  Future<String> _getDeviceIp() async {
    try {
      final info = NetworkInfo();
      final wifiIP = await info.getWifiIP();
      return wifiIP ?? "Unknown IP";
    } catch (e) {
      return "IP Error";
    }
  }

  /// Check-in
  Future<bool> checkIn() async {
    if (isCheckedIn) {
      debugPrint("⚠️ Already checked in, ignoring new check-in.");
      return false;
    }

    checkInTime = DateFormat('hh:mm a').format(DateTime.now());
    checkOutTime = null; // reset
    location = await _getLocation();
    deviceIp = await _getDeviceIp();

    isCheckedIn = true;
    notifyListeners();

    debugPrint(
      "✅ Checked in at $checkInTime | $location | $deviceIp | Mode: ${isOnsite ? "Onsite" : "WFH"}",
    );
    return true;
  }

  /// Check-out
  Future<bool> checkOut() async {
    if (!isCheckedIn) {
      debugPrint("⚠️ Not checked in, cannot check out.");
      return false;
    }

    checkOutTime = DateFormat('hh:mm a').format(DateTime.now());
    location = await _getLocation();
    deviceIp = await _getDeviceIp();

    isCheckedIn = false;
    notifyListeners();

    debugPrint(
      "✅ Checked out at $checkOutTime | $location | $deviceIp | Mode: ${isOnsite ? "Onsite" : "WFH"}",
    );
    return true;
  }
}

import 'dart:async';
import 'dart:io';

/// Service to check network connectivity
class NetworkInfo {
  /// Checks if the device has an active internet connection
  Future<bool> get isConnected async {
    try {
      final result = await InternetAddress.lookup('example.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  /// Checks if the device has an active internet connection with a timeout
  Future<bool> isConnectedWithTimeout(
      {Duration timeout = const Duration(seconds: 5)}) async {
    try {
      final result =
          await InternetAddress.lookup('example.com').timeout(timeout);
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    } on TimeoutException catch (_) {
      return false;
    }
  }
}

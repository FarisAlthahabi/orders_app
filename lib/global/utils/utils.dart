import 'dart:io';

abstract class Utils {
  static String detectBaseUrlForPlatform() {
    if (Platform.isAndroid) {
      return 'http://10.0.2.2:8000/';
    } else {
      return 'http://127.0.0.1:8000/';
    }
  }
}

import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

@module
abstract class AppModule {
  @singleton
  Future<bool> disablePrintOnRelease() async {
    if (kReleaseMode) {
      debugPrint = (String? message, {int? wrapWidth}) {};
    }

    return true;
  }
}

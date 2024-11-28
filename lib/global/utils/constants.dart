import 'package:flutter/material.dart';

abstract class AppConstants {
  static final circularBorderRadius = BorderRadius.circular(100);

  static const duration2s = Duration(seconds: 2);
  static const duration1s = Duration(seconds: 1);
  static const duration200ms = Duration(microseconds: 200);

  static const padding32V16H = EdgeInsets.symmetric(
    vertical: 32,
    horizontal: 16,
  );
}

import 'package:flutter/material.dart';

abstract class AppConstants {
  static final circularBorderRadius = BorderRadius.circular(100);
  static final borderRadius16 = BorderRadius.circular(16);

  static const duration2s = Duration(seconds: 2);
  static const duration1s = Duration(seconds: 1);
  static const duration200ms = Duration(microseconds: 200);

  static const padding32V16H = EdgeInsets.symmetric(
    vertical: 32,
    horizontal: 16,
  );
  static const padding0 = EdgeInsets.zero;
  static const padding2 = EdgeInsets.all(2);
  static const padding16 = EdgeInsets.all(16);
  static const padding20 = EdgeInsets.all(20);
  static const paddingT120 = EdgeInsets.only(top: 120);
}

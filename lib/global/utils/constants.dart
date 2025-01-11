import 'package:flutter/material.dart';

abstract class AppConstants {
  static const circularBorderRadius = BorderRadius.all(Radius.circular(100));
  static const borderRadius16 = BorderRadius.all(Radius.circular(16));
  static const borderRadius32 = BorderRadius.all(Radius.circular(32));
  static const borderRadius8 = BorderRadius.all(Radius.circular(8));
  static const borderRadiusTop = BorderRadius.only(
    topLeft: Radius.circular(25),
    topRight: Radius.circular(25),
  );

  static const duration15s = Duration(seconds: 15);
  static const duration10s = Duration(seconds: 10);
  static const duration2s = Duration(seconds: 2);
  static const duration1s = Duration(seconds: 1);
  static const duration200ms = Duration(milliseconds: 200);
  static const duration600ms = Duration(milliseconds: 600);

  static const padding32V16H = EdgeInsets.symmetric(
    vertical: 32,
    horizontal: 16,
  );
  static const padding0 = EdgeInsets.zero;
  static const padding2 = EdgeInsets.all(2);
  static const padding8 = EdgeInsets.all(8);
  static const padding4 = EdgeInsets.all(4);
  static const padding10 = EdgeInsets.all(10);
  static const padding16 = EdgeInsets.all(16);
  static const paddingL16 = EdgeInsets.only(left: 16);
  static const paddingB16 = EdgeInsets.only(bottom: 16);
  static const padding20 = EdgeInsets.all(20);
  static const paddingT120 = EdgeInsets.only(top: 120);
  static const paddingT265 = EdgeInsets.only(top: 265);
}

import 'package:flutter/material.dart';
import 'package:orders_app/global/theme/components/colors.dart';

abstract class AppShadows {
  static const shadow1 = [
    BoxShadow(
      color: AppColors.shadowColor1,
      offset: Offset(0, 3.71),
      blurRadius: 3.71,
      spreadRadius: 0,
    ),
  ];

  static final shadow2 = [
    BoxShadow(
      color: AppColors.shadowColor2.withOpacity(0.03),
      offset: Offset(0, 0),
      blurRadius: 1,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: AppColors.shadowColor3.withOpacity(0.04),
      offset: Offset(0, 4),
      blurRadius: 20,
      spreadRadius: -2,
    ),
  ];

  static final shadow3 = [
    BoxShadow(
      color: AppColors.white.withOpacity(0.7),
      offset: Offset(0, 0),
      blurRadius: 8,
      spreadRadius: 0,
    ),
    
  ];
}

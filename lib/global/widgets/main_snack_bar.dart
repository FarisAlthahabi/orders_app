import 'package:flutter/material.dart';
import 'package:orders_app/global/theme/components/colors.dart';
import 'package:orders_app/global/utils/constants.dart';

abstract class MainSnackBar {
  static void showSuccessMessage(
    BuildContext context,
    String message, {
    Color? color,
    Duration? duration,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: duration ?? AppConstants.duration2s,
        backgroundColor: color ?? AppColors.green,
        content: Center(
          child: Text(message),
        ),
      ),
    );
  }

  static void showErrorMessage(
    BuildContext context,
    String message, {
    Color? color,
    Duration? duration,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: duration ?? AppConstants.duration2s,
        backgroundColor: color ?? AppColors.red,
        content: Center(
          child: Text(message),
        ),
      ),
    );
  }
}

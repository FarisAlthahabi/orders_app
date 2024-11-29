import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:orders_app/global/theme/components/colors.dart';
import 'package:orders_app/global/utils/constants.dart';

class MainButton extends StatefulWidget {
  const MainButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.textColor,
    this.duration,
    this.buttonColor,
    this.width,
    this.border,
    this.height,
  });

  final VoidCallback onPressed;
  final Duration? duration;
  final Color? buttonColor;
  final String text;
  final Color? textColor;
  final double? width;
  final double? height;
  final BoxBorder? border;

  @override
  State<MainButton> createState() => _MainButtonState();
}

class _MainButtonState extends State<MainButton> {
  @override
  Widget build(BuildContext context) {
    return Bounce(
      duration: widget.duration ?? AppConstants.duration200ms,
      onPressed: widget.onPressed,
      child: Container(
        constraints: BoxConstraints(maxHeight: 70),
        height: widget.height,
        width: widget.width ?? double.maxFinite,
        padding: AppConstants.padding20,
        decoration: BoxDecoration(
          border: widget.border,
          color: widget.buttonColor ?? AppColors.mainColor,
          borderRadius: AppConstants.borderRadius16,
        ),
        child: Center(
          child: Text(
            widget.text,
            style: TextStyle(
              color: widget.textColor ?? AppColors.white,
              height: 1.19,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

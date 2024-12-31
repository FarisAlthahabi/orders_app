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
    this.fontSize,
    this.shadow,
    this.fontWeight,
    this.borderRadius,
    this.padding,
    this.child,
  });

  final VoidCallback onPressed;
  final Duration? duration;
  final Color? buttonColor;
  final String text;
  final Color? textColor;
  final double? width;
  final double? height;
  final BoxBorder? border;
  final double? fontSize;
  final List<BoxShadow>? shadow;
  final FontWeight? fontWeight;
  final BorderRadius? borderRadius;
  final EdgeInsets? padding;
  final Widget? child;

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
        //constraints: BoxConstraints(maxHeight: 80),
        height: widget.height,
        width: widget.width ?? double.maxFinite,
        padding: widget.padding ?? AppConstants.padding20,
        decoration: BoxDecoration(
          border: widget.border,
          color: widget.buttonColor ?? AppColors.mainColor,
          borderRadius: widget.borderRadius ?? AppConstants.borderRadius16,
          boxShadow: widget.shadow,
        ),
        child: widget.child ?? Center(
          child: Text(
            widget.text,
            style: TextStyle(
              color: widget.textColor ?? AppColors.white,
              height: 1.19,
              fontSize: widget.fontSize ?? 20,
              fontWeight: widget.fontWeight ?? FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

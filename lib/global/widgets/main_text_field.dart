import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:orders_app/global/theme/components/colors.dart';

class MainTextField extends StatefulWidget {
  const MainTextField({
    super.key,
    this.hintText,
    required this.onChanged,
    this.textInputType,
    required this.onSubmitted,
    required this.focusNode,
    this.inputFormatters,
  });

  final String? hintText;
  final ValueSetter<String> onChanged;
  final ValueSetter<String> onSubmitted;
  final FocusNode focusNode;
  final TextInputType? textInputType;
  final List<TextInputFormatter>? inputFormatters;

  @override
  State<MainTextField> createState() => _MainTextFieldState();
}

class _MainTextFieldState extends State<MainTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: widget.onChanged,
      onSubmitted: widget.onSubmitted,
      focusNode: widget.focusNode,
      keyboardType: widget.textInputType ?? TextInputType.name,
      inputFormatters: widget.inputFormatters,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.all(20),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: AppColors.grey.withOpacity(0.5))),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: AppColors.grey.withOpacity(0.5))),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: AppColors.grey.withOpacity(0.5))),
          hintText: widget.hintText,
          hintStyle: TextStyle(
            color: AppColors.grey,
            fontSize: 18,
            fontWeight: FontWeight.w400,
            height: 1.19,
          )),
    );
  }
}

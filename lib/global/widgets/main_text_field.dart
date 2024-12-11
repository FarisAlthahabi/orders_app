import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:orders_app/global/theme/components/colors.dart';

class MainTextField extends StatefulWidget {
  const MainTextField({
    super.key,
    required this.onChanged,
    required this.onSubmitted,
    required this.focusNode,
    this.textInputType,
    this.hintText,
    this.inputFormatters,
    this.isPassword = false,
    this.readOnly = false,
    this.initialText,
    this.prefixIcon,
    this.prefixIconColor,
    this.errorText,
  });

  final String? hintText;
  final String? initialText;
  final ValueSetter<String> onChanged;
  final ValueSetter<String> onSubmitted;
  final FocusNode focusNode;
  final TextInputType? textInputType;
  final List<TextInputFormatter>? inputFormatters;
  final bool isPassword;
  final bool readOnly;
  final Widget? prefixIcon;
  final Color? prefixIconColor;
  final String? errorText;

  @override
  State<MainTextField> createState() => _MainTextFieldState();
}

class _MainTextFieldState extends State<MainTextField> {
  late bool isObscure = widget.isPassword;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: widget.initialText,
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onSubmitted,
      focusNode: widget.focusNode,
      obscureText: isObscure,
      keyboardType: widget.textInputType ?? TextInputType.name,
      inputFormatters: widget.inputFormatters,
      readOnly: widget.readOnly,
      decoration: InputDecoration(
        errorStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        errorText: widget.errorText,
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
        ),
        suffixIcon: widget.isPassword
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    isObscure = !isObscure;
                  });
                },
                child: Icon(
                  isObscure
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: AppColors.grey,
                ),
              )
            : null,
        prefixIcon: widget.prefixIcon,
        prefixIconColor: widget.prefixIconColor ?? AppColors.greyShade2,
      ),
    );
  }
}

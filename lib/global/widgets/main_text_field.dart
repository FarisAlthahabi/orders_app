import 'package:flutter/material.dart';

class MainTextField extends StatefulWidget {
  const MainTextField({
    super.key,
    this.hintText,
    required this.onChanged,
    this.textInputType,
  });

  final String? hintText;
  final ValueSetter<String> onChanged;
  final TextInputType? textInputType;

  @override
  State<MainTextField> createState() => _MainTextFieldState();
}

class _MainTextFieldState extends State<MainTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: widget.onChanged,
      keyboardType: widget.textInputType ?? TextInputType.name,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.all(20),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide:
                  BorderSide(color: Color(0xFF8E8EA9).withOpacity(0.5))),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide:
                  BorderSide(color: Color(0xFF8E8EA9).withOpacity(0.5))),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide:
                  BorderSide(color: Color(0xFF8E8EA9).withOpacity(0.5))),
          hintText: widget.hintText,
          hintStyle: TextStyle(
            color: Color(0xFF8E8EA9),
            fontSize: 18,
            fontWeight: FontWeight.w400,
            height: 1.19,
          )),
    );
  }
}

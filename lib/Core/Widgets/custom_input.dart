import 'package:app_26/Core/Static/colors.dart';
import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  const CustomInput({
    super.key,
    required this.controller,
    required this.hintText,
    this.suffixIcon,
    this.validator,
    this.onChanged,
  });
  final TextEditingController controller;
  final String hintText;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        hintText: hintText,
        border: border(Palette.grey),
        filled: true,
        enabledBorder: border(Palette.grey),
        focusedBorder: border(Palette.kPrimary),
        errorBorder: border(Palette.red),
      ),
    );
  }

  OutlineInputBorder border(Color borderColor) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(
          color: borderColor,
        ),
      );
}

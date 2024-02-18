import 'package:app_26/Core/Static/colors.dart';
import 'package:app_26/Core/Static/texts.dart';
import 'package:app_26/Core/Util/util.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomInputField extends StatelessWidget {
  const CustomInputField({
    super.key,
    required this.controller,
    required this.hintText,
    this.suffixIcon,
    this.validator,
    this.onChanged,
    required this.title,
    this.titleSize,
  });
  final TextEditingController controller;
  final String hintText;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final String title;
  final double? titleSize;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: Util.gradient(),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Texts.bold(
            text: title,
            fontSize: titleSize ?? 18.sp,
            padding: EdgeInsets.only(left: 2.w),
            color: Palette.white,
          ),
          TextFormField(
            onChanged: onChanged,
            controller: controller,
            validator: validator,
            maxLines: 10,
            decoration: InputDecoration(
              suffixIcon: suffixIcon,
              hintText: hintText,
              border: border(Palette.grey),
              enabledBorder: border(Palette.grey),
              focusedBorder: border(Palette.kPrimary),
              errorBorder: border(Palette.red),
            ),
          ),
        ],
      ),
    );
  }

  OutlineInputBorder border(Color borderColor) => OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: const BorderSide(
          color: Colors.transparent,
        ),
      );
}

import 'package:app_26/Core/Static/colors.dart';
import 'package:app_26/Core/Static/texts.dart';
import 'package:app_26/Core/Util/util.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomInput extends StatelessWidget {
  const CustomInput({
    super.key,
    required this.controller,
    required this.hintText,
    this.suffixIcon,
    this.validator,
    this.onChanged,
    this.maxLength,
    this.focusNode,
    this.textAlign = TextAlign.start,
    this.prefixIcon,
    this.readOnly = false,
    this.titleSize,
    required this.title,
  });

  final TextEditingController controller;
  final String hintText;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final int? maxLength;
  final FocusNode? focusNode;
  final TextAlign textAlign;
  final Widget? prefixIcon;
  final bool readOnly;
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
            fontSize: titleSize ?? 14.sp,
            padding: EdgeInsets.only(left: 2.w),
            color: Palette.white,
          ),
          TextFormField(
            textAlign: textAlign,
            focusNode: focusNode,
            onChanged: onChanged,
            controller: controller,
            validator: validator,
            maxLength: maxLength,
            readOnly: readOnly,
            decoration: InputDecoration(
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              hintText: hintText,
              border: border(Palette.grey),
              counterText: "",
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

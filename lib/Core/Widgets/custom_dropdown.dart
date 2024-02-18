import 'package:app_26/Core/Static/colors.dart';
import 'package:app_26/Core/Static/texts.dart';
import 'package:app_26/Core/Util/util.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomDropdown extends StatelessWidget {
  const CustomDropdown({
    super.key,
    required this.items,
    required this.value,
    required this.onChanged,
  });
  final List<String> items;
  final String value;
  final Function(String?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: Util.gradient(), borderRadius: BorderRadius.circular(20)),
      child: DropdownButtonFormField(
        dropdownColor: Palette.gradient1,
        iconEnabledColor: Palette.white,
        iconSize: 13.sp,
        focusColor: Palette.filled,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(20),
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(20),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.transparent),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        isExpanded: true,
        value: value,
        items: items
            .map(
              (e) => DropdownMenuItem(
                value: e,
                child: Texts.regular(
                  text: e,
                  color: Palette.white,
                ),
              ),
            )
            .toList(),
        onChanged: onChanged,
      ),
    );
  }
}

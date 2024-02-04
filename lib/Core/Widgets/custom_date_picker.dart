import 'package:app_26/Core/Static/colors.dart';
import 'package:app_26/Core/Static/texts.dart';
import 'package:app_26/Core/Util/util.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomDatePicker extends StatelessWidget {
  const CustomDatePicker({
    super.key,
    required this.date,
    required this.onPress,
  });
  final DateTime date;
  final Function(DateTime?) onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final dateT = await showDatePicker(
          context: context,
          initialDate: date,
          currentDate: date,
          firstDate: DateTime(1900),
          lastDate: DateTime(2030),
        );

        onPress(dateT);
      },
      child: Container(
        padding: EdgeInsets.only(left: 5.w),
        alignment: Alignment.centerLeft,
        width: double.infinity,
        height: 6.h,
        decoration: BoxDecoration(
          color: Palette.filled,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Texts.regular(
          text: Util.formatDate(date),
        ),
      ),
    );
  }
}

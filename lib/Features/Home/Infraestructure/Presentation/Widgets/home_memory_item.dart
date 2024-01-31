import 'package:app_26/Core/Static/colors.dart';
import 'package:app_26/Core/Static/texts.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

class HomeMemoryItem extends StatelessWidget {
  const HomeMemoryItem({
    super.key,
    required this.index,
    required this.isLocked,
  });
  final int index;
  final bool isLocked;
  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: () {
        if (isLocked) return;
        context.go("/memory");
      },
      style: FilledButton.styleFrom(
        shape: const CircleBorder(),
        backgroundColor: Palette.pink,
      ),
      child: isLocked
          ? Icon(
              Icons.lock,
              color: Colors.white,
              size: 16.sp,
            )
          : Texts.bold(
              text: (index + 1).toString(),
              fontSize: 6.sp,
              color: Palette.white,
            ),
    );
  }
}

import 'package:app_26/Core/Static/assets.dart';
import 'package:app_26/Core/Static/colors.dart';
import 'package:app_26/Core/Static/texts.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

class HomeMemoryItem extends StatelessWidget {
  const HomeMemoryItem({super.key, required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: () => context.go("/memory"),
      style: FilledButton.styleFrom(
        shape: const CircleBorder(),
        backgroundColor: Palette.pink,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            "${assetImage}love.png",
          ),
          Texts.bold(
            text: (index + 1).toString(),
            fontSize: 6.sp,
            color: Palette.black,
          ),
        ],
      ),
    );
  }
}

import 'package:app_26/Core/Static/colors.dart';
import 'package:easy_padding/easy_padding.dart';
import 'package:flutter/material.dart';

class MemoryTitle extends StatelessWidget {
  const MemoryTitle({
    super.key,
    required this.child,
    this.padding = 20,
    this.color,
  });
  final Widget child;
  final double padding;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shadowColor: color ?? Palette.filled,
      color: color ?? Palette.filled,
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.circular(40),
      ),
      child: child.all(padding),
    );
  }
}

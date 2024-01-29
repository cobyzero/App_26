import 'package:easy_padding/easy_padding.dart';
import 'package:flutter/material.dart';

class MemoryTitle extends StatelessWidget {
  const MemoryTitle({
    super.key,
    required this.child,
    this.padding = 20,
  });
  final Widget child;
  final double padding;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.circular(40),
      ),
      child: child.all(padding),
    );
  }
}

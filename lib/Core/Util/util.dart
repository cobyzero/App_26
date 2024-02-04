import 'package:app_26/Core/Static/colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

class Util {
  static void showMessage(String message, BuildContext context) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: Palette.kPrimary,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(3.w),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void loading(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return Dialog(
          shape: const CircleBorder(),
          insetPadding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  width: 10.h,
                  height: 10.h,
                  child: const CircularProgressIndicator(
                    color: Palette.kPrimary,
                    strokeWidth: 8,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static void close(BuildContext context) {
    GoRouter.of(context).pop();
  }

  static Widget loadingWidget() {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: 10.h,
              height: 10.h,
              child: const CircularProgressIndicator(
                color: Palette.kPrimary,
                strokeWidth: 8,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static String formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }
}

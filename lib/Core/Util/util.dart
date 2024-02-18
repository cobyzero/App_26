import 'package:app_26/Core/Static/colors.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quickalert/quickalert.dart';
import 'package:sizer/sizer.dart';

class Util {
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

  static Widget loadingWidget({Color color = Palette.kPrimary}) {
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
              child: CircularProgressIndicator(
                color: color,
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

  static Future<String> getImage(String userId, String image) async {
    final storageRef = FirebaseStorage.instance.ref();

    final imageUrl = await storageRef.child("$userId/$image").getDownloadURL();
    return imageUrl;
  }

  static void showInfo({
    required BuildContext context,
    required String text,
    required Function() onConfirm,
  }) {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.info,
      title: text,
      confirmBtnText: 'Esta bien',
      barrierDismissible: false,
      confirmBtnColor: Palette.kPrimary,
      onConfirmBtnTap: () {
        Navigator.pop(context);
        onConfirm();
      },
    );
  }

  static void showSucces({
    required BuildContext context,
    required String text,
    required Function() onConfirm,
  }) {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.success,
      title: text,
      confirmBtnText: 'Esta bien',
      barrierDismissible: false,
      confirmBtnColor: Palette.kPrimary,
      onConfirmBtnTap: () {
        Navigator.pop(context);
        onConfirm();
      },
    );
  }

  static void showError({
    required BuildContext context,
    required String text,
    required Function() onConfirm,
  }) {
    QuickAlert.show(
      context: context,
      barrierDismissible: false,
      type: QuickAlertType.error,
      title: text,
      confirmBtnText: 'Esta bien',
      confirmBtnColor: Palette.kPrimary,
      onConfirmBtnTap: () {
        Navigator.pop(context);
        onConfirm();
      },
    );
  }

  static LinearGradient gradient() {
    return const LinearGradient(
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
      colors: [
        Palette.gradient1,
        Palette.gradient2,
      ],
    );
  }
}

import 'package:app_26/Core/Static/assets.dart';
import 'package:app_26/Core/Static/colors.dart';
import 'package:app_26/Core/Static/texts.dart';
import 'package:app_26/Features/Home/Infraestructure/Presentation/Widgets/home_memory_item.dart';
import 'package:easy_padding/easy_padding.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfffff4f5),
      floatingActionButton: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Palette.pink,
            side: const BorderSide(
              width: .5,
              color: Palette.white,
            )),
        onPressed: () {},
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Texts.bold(
              text: "Conseguir llaves",
              fontSize: 8.sp,
              color: Palette.white,
            ).only(right: 10),
            Icon(
              Icons.vpn_key,
              color: Colors.yellow,
            )
          ],
        ),
      ).only(bottom: 20, right: 20, left: 20),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: SafeArea(
          child: SizedBox.expand(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Texts.bold(
              text: "Bienvenida!\n elige un recuerdo",
              fontSize: 10.sp,
              alignment: TextAlign.center,
            ).all(20),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10.w,
                  mainAxisSpacing: 2.h,
                  childAspectRatio: 1.4,
                ),
                itemCount: 40,
                itemBuilder: (context, index) {
                  return HomeMemoryItem(
                    index: index,
                  );
                },
              ).only(top: 3.h),
            ),
          ],
        ),
      )),
    );
  }
}

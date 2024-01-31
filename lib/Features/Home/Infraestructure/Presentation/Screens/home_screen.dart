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
      floatingActionButton: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Palette.kPrimary,
          side: const BorderSide(
            width: .5,
            color: Palette.white,
          ),
        ),
        onPressed: () {},
        child: SizedBox(
          width: double.infinity,
          height: 5.h,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Texts.bold(
                text: "Conseguir llaves",
                fontSize: 8.sp,
                color: Palette.white,
              ).only(right: 10),
              const Icon(
                Icons.vpn_key,
                color: Colors.yellow,
              )
            ],
          ),
        ),
      ).only(bottom: 20, right: 20, left: 20),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: SafeArea(
          child: SizedBox.expand(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Palette.kPrimary,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Texts.bold(
                        text: "Bienvenida!",
                        fontSize: 8.sp,
                        alignment: TextAlign.center,
                        color: Palette.grey,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.vpn_key,
                            color: Colors.yellow,
                          ).only(right: 10),
                          Texts.bold(
                            text: "3",
                            fontSize: 6.sp,
                            alignment: TextAlign.center,
                            color: Palette.grey,
                          ),
                        ],
                      )
                    ],
                  ).only(bottom: 10),
                  Texts.regular(
                    text: "Elige un recuerdo y descubre",
                    fontSize: 6.sp,
                    alignment: TextAlign.center,
                    color: Palette.grey,
                  ),
                ],
              ),
            ),
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
                    isLocked: index % 2 != 0,
                  ).only(top: 1.h);
                },
              ),
            ),
          ],
        ),
      )),
    );
  }
}

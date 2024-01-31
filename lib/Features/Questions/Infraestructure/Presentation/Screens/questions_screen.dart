import 'package:app_26/Core/Static/colors.dart';
import 'package:app_26/Core/Static/texts.dart';
import 'package:app_26/Core/Widgets/custom_button.dart';
import 'package:app_26/Features/Memory/Infraestructure/Presentation/Widgets/memory_title.dart';
import 'package:easy_padding/easy_padding.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

class QuestionsScreen extends StatelessWidget {
  const QuestionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SizedBox.expand(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MemoryTitle(
                  padding: 10,
                  child: BackButton(
                    onPressed: () {
                      context.go("/home");
                    },
                    color: Palette.pink,
                  ),
                ),
                MemoryTitle(
                  child: Texts.bold(
                    text: "Preguntas",
                    fontSize: 10.sp,
                  ),
                ),
                MemoryTitle(
                  child: Row(
                    children: [
                      const Icon(
                        Icons.vpn_key,
                        color: Colors.yellow,
                      ).only(right: 10),
                      Texts.bold(
                        text: "3",
                        fontSize: 6.sp,
                        alignment: TextAlign.center,
                        color: Palette.black,
                      ),
                    ],
                  ),
                ),
              ],
            ).symmetric(
              horizontal: 5.w,
              vertical: 2.h,
            ),
            MemoryTitle(
              child: Texts.bold(
                text: "¿Cuantos años tengo?",
                fontSize: 6.sp,
                alignment: TextAlign.center,
                color: Palette.black,
              ),
            ).only(bottom: 5.h),
            Expanded(
              child: ListView.builder(
                itemCount: 4,
                itemBuilder: (context, index) {
                  return MemoryTitle(
                    padding: 10,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MemoryTitle(
                          color: Palette.white,
                          padding: 10,
                          child: Texts.bold(
                            text: (index + 1).toString(),
                            fontSize: 6.sp,
                            alignment: TextAlign.center,
                            color: Palette.black,
                          ),
                        ),
                        Texts.bold(
                          text: "13",
                          fontSize: 6.sp,
                          alignment: TextAlign.center,
                          color: Palette.black,
                        ),
                        const SizedBox.shrink(),
                      ],
                    ),
                  ).symmetric(vertical: 1.h, horizontal: 10.w);
                },
              ),
            ),
            CustomButton(
              onTap: () {},
              child: Texts.bold(
                text: "Confirmar",
                fontSize: 6.sp,
                alignment: TextAlign.center,
                color: Palette.white,
              ),
            ).symmetric(vertical: 4.h, horizontal: 10.w),
          ],
        ),
      )),
    );
  }
}

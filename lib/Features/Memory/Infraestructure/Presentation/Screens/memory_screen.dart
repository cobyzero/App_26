import 'package:app_26/Core/Static/assets.dart';
import 'package:app_26/Core/Static/colors.dart';
import 'package:app_26/Core/Static/texts.dart';
import 'package:app_26/Features/Memory/Infraestructure/Presentation/Widgets/memory_title.dart';
import 'package:easy_padding/easy_padding.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

class MemoryScreen extends StatelessWidget {
  const MemoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SizedBox.expand(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Texts.bold(
                          text: "Recuerdo: ",
                          fontSize: 10.sp,
                        ),
                        Texts.bold(
                          text: "12/10/2021",
                          fontSize: 10.sp,
                          color: Palette.pink,
                        )
                      ],
                    ),
                  )
                ],
              ).symmetric(
                horizontal: 5.w,
                vertical: 2.h,
              ),
              MemoryTitle(
                child: SizedBox(
                  width: double.infinity,
                  child: Texts.regular(
                    alignment: TextAlign.start,
                    text: """¡Hola mi amor!
          
Quiero agradecerte de corazón por el día de playa increíble que tuvimos juntos. Fue tan genial que ni siquiera puedo encontrar las palabras adecuadas para describir lo feliz que me hiciste sentir.
          
Desde el momento en que llegamos y sentimos la arena bajo nuestrospies, hasta cuando nos sumergimos en el agua y nos reímos comoniños, cada instante fue perfecto. ¡Hasta construir esos castillosde arena fue una tontería tan divertida!

Gracias por compartir risas, secretos y hasta por aguantar mischistes malos. La verdad es que no puedo imaginar un día mejor queese, y todo gracias a ti. Tu compañía hizo que cada momento fueraespecial, y estoy agradecido/a de tenerte a mi lado.

Espero que haya muchos más días como ese en nuestro futuro. Gracias por ser la mejor parte de mis días y por hacerlos inolvidables.""",
                    fontSize: 7.sp,
                    color: Palette.black,
                  ),
                ),
              ).symmetric(
                horizontal: 5.w,
                vertical: 2.h,
              ),
              MemoryTitle(
                padding: 0,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: const DecorationImage(
                        image: AssetImage(
                          "${assetImage}yo.jpg",
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ).symmetric(horizontal: 5.w),
            ],
          ),
        ),
      )),
    );
  }
}

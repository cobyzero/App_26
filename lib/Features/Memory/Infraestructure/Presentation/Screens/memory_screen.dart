import 'package:animated_size_and_fade/animated_size_and_fade.dart';
import 'package:app_26/Core/Static/assets.dart';
import 'package:app_26/Core/Static/colors.dart';
import 'package:app_26/Core/Static/texts.dart';
import 'package:app_26/Core/Util/util.dart';
import 'package:app_26/Features/Home/Domain/Entities/memory_entity.dart';
import 'package:app_26/Features/Memory/Application/Blocs/memory_bloc/memory_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_padding/easy_padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

class MemoryScreen extends StatelessWidget {
  const MemoryScreen({
    super.key,
    required this.entity,
  });
  final MemoryEntity entity;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MemoryBloc()
        ..add(
          MemoryEventLoadedImages(
            entity.image,
            entity.userId,
          ),
        ),
      child: Scaffold(
        body: BlocBuilder<MemoryBloc, MemoryState>(
          builder: (context, state) {
            if (state.images.isEmpty) {
              return Center(
                child: Util.loadingWidget(),
              );
            }

            return SafeArea(
                child: SizedBox.expand(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BackButton(
                          onPressed: () {
                            context.go("/main");
                          },
                          color: Palette.kPrimary,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Texts.bold(
                              text: "Recuerdo: ",
                            ),
                            Texts.bold(
                              text: "${entity.date.day}/${entity.date.month}/${entity.date.year}",
                              color: Palette.kPrimary,
                            ),
                          ],
                        ),
                        const IconButton(
                          onPressed: null,
                          color: Palette.pink,
                          icon: Icon(Icons.lock),
                        ),
                      ],
                    ).only(
                      top: 2.h,
                      left: 4.w,
                      right: 4.w,
                    ),
                    Texts.bold(
                      text: "Autor: ${entity.nameUser}",
                      color: Palette.gradient2,
                      fontSize: 12.sp,
                    ).only(bottom: 4.h),
                    GestureDetector(
                      onTap: () {
                        context.read<MemoryBloc>().add(
                              MemoryEventOpen(),
                            );
                      },
                      child: Container(
                        padding: EdgeInsets.all(4.w),
                        decoration: BoxDecoration(
                          gradient: Util.gradient(),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Container(
                          width: double.infinity,
                          alignment: state.isOpen ? Alignment.topLeft : Alignment.center,
                          child: AnimatedSizeAndFade(
                            fadeDuration: const Duration(milliseconds: 300),
                            sizeDuration: const Duration(milliseconds: 600),
                            child: state.isOpen
                                ? Texts.regular(
                                    alignment: TextAlign.start,
                                    text: entity.message,
                                    color: Palette.white,
                                    height: 2,
                                  )
                                : Image.asset(
                                    "${assetImage}love-and-romance.png",
                                    height: 20.h,
                                  ),
                          ),
                        ),
                      ),
                    ).only(bottom: 4.h, right: 9.w, left: 9.w),
                    CarouselSlider(
                      options: CarouselOptions(
                        aspectRatio: 1,
                        enlargeCenterPage: true,
                        enableInfiniteScroll: state.images.length > 3,
                      ),
                      items: state.images.map((i) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(horizontal: 5.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                              image: NetworkImage(i),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                  ],
                ),
              ),
            ));
          },
        ),
      ),
    );
  }
}

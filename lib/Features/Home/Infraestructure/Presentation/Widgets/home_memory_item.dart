import 'package:app_26/Core/Static/colors.dart';
import 'package:app_26/Core/Static/texts.dart';
import 'package:app_26/Core/Util/util.dart';
import 'package:app_26/Features/Auth/Domain/Entities/user_entity.dart';
import 'package:app_26/Features/Home/Application/bloc/home_bloc.dart';
import 'package:app_26/Features/Home/Domain/Entities/memory_entity.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_padding/easy_padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

class HomeMemoryItem extends StatelessWidget {
  const HomeMemoryItem({
    super.key,
    required this.index,
    required this.memory,
    required this.user,
    required this.isLoading,
  });
  final int index;
  final MemoryEntity memory;
  final UserEntity user;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        4.w,
        4.w,
        4.w,
        8.w,
      ),
      decoration: BoxDecoration(
        color: Palette.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.7),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Container(
        color: Palette.kPrimary,
        child: FutureBuilder(
          future: Util.getImage(user.id, memory.image[0]),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  Expanded(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              colorFilter: memory.isBlocked
                                  ? const ColorFilter.mode(
                                      Palette.grey2,
                                      BlendMode.color,
                                    )
                                  : null,
                              image: CachedNetworkImageProvider(snapshot.data!),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Palette.black.withOpacity(.7),
                              ],
                            ),
                          ),
                        ),
                        memory.isBlocked
                            ? Visibility(
                                visible: !isLoading,
                                child: GestureDetector(
                                  onTap: () {
                                    if (user.keys == 0) {
                                      Util.showError(
                                        text: 'No cuentas con llaves suficientes',
                                        context: context,
                                        onConfirm: () {},
                                      );

                                      return;
                                    }

                                    context.read<HomeBloc>().add(
                                          HomeEventUnlockMemory(
                                            memory.id,
                                            index: index,
                                            userId: user.id,
                                            keys: user.keys,
                                          ),
                                        );
                                  },
                                  child: Icon(
                                    Icons.lock,
                                    color: Palette.white,
                                    size: 40.sp,
                                    shadows: const [
                                      BoxShadow(
                                        color: Palette.kPrimary,
                                        offset: Offset.zero,
                                        blurRadius: 10,
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : Visibility(
                                visible: !isLoading,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const SizedBox.shrink(),
                                    const SizedBox.shrink(),
                                    GestureDetector(
                                      onTap: () => context.go("/memory", extra: memory),
                                      child: Container(
                                        height: 4.h,
                                        margin: EdgeInsets.symmetric(horizontal: 5.w),
                                        decoration: BoxDecoration(
                                          gradient: Util.gradient(),
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            const Texts.regular(
                                              text: "Ver",
                                              color: Palette.white,
                                            ),
                                            Icon(
                                              Icons.arrow_right,
                                              size: 20.sp,
                                              color: Palette.white,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Texts.regular(
                                            text: memory.nameUser == user.name ? "Yo" : memory.nameUser,
                                            color: Palette.white,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Texts.regular(
                                              text: memory.image.length.toString(),
                                              color: Palette.white,
                                            ),
                                            const Icon(
                                              Icons.photo_camera,
                                              color: Palette.white,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ).all(2.w)
                                  ],
                                ),
                              ),
                        Visibility(
                          visible: isLoading,
                          child: SizedBox(
                            width: 6.h,
                            height: 6.h,
                            child: const CircularProgressIndicator(
                              strokeWidth: 8,
                              color: Palette.kPrimary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }

            return Util.loadingWidget(color: Palette.white);
          },
        ),
      ),
    );
  }
}

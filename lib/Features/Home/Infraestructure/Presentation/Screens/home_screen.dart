import 'package:app_26/Core/Dependencies/injector.dart';
import 'package:app_26/Core/Static/assets.dart';
import 'package:app_26/Core/Static/colors.dart';
import 'package:app_26/Core/Static/texts.dart';
import 'package:app_26/Core/Util/util.dart';
import 'package:app_26/Features/Auth/Domain/Entities/user_entity.dart';
import 'package:app_26/Features/Home/Application/bloc/home_bloc.dart';
import 'package:app_26/Features/Home/Domain/Entities/memory_entity.dart';
import 'package:app_26/Features/Home/Domain/Repositories/home_repository.dart';
import 'package:app_26/Features/Home/Infraestructure/Presentation/Widgets/home_memory_item.dart';
import 'package:easy_padding/easy_padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.userEntity});
  final UserEntity userEntity;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(getIt.get<HomeRepository>())
        ..add(
          HomeEventGetMemorys(userEntity.id),
        ),
      child: Scaffold(
        backgroundColor: const Color(0xffEFF1F5),
        body: SafeArea(
          child: SizedBox.expand(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(4.w),
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Color(0xffF9F9F9),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Texts.bold(
                            text: "26 ",
                            alignment: TextAlign.center,
                            color: Palette.kPrimary,
                            fontSize: 25.sp,
                          ),
                          Texts.bold(
                            text: "Recuerdos",
                            alignment: TextAlign.center,
                            color: Palette.kPrimary,
                            fontSize: 22.sp,
                          ),
                        ],
                      ),
                      Container(
                        width: 12.w,
                        height: 12.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 1,
                            color: Palette.grey2,
                          ),
                          image: const DecorationImage(
                            alignment: Alignment.topCenter,
                            image: AssetImage(
                              "${assetImage}profile.jpg",
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 4.h,
                  ),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(30),
                    gradient: Util.gradient(),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Texts.regular(
                            text: "Bienvenido(a)!",
                            fontSize: 12.sp,
                            alignment: TextAlign.center,
                            color: Palette.white,
                          ),
                          Texts.bold(
                            text: userEntity.name,
                            fontSize: 16.sp,
                            color: Palette.white,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.vpn_key,
                            color: Colors.yellow,
                            size: 20.sp,
                          ).only(right: 10),
                          Texts.bold(
                            text: userEntity.keys.toString(),
                            fontSize: 30.sp,
                            color: Palette.white,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    if (state is HomeComplete) {
                      return Expanded(
                        child: StreamBuilder<Iterable<MemoryEntity>>(
                            stream: state.memorys,
                            builder: (context, snapshotMemory) {
                              if (snapshotMemory.hasData) {
                                if (snapshotMemory.data!.isEmpty) {
                                  return const Center(
                                    child: Texts.regular(
                                      text: "No tienes memorias actualmente",
                                    ),
                                  );
                                }

                                return GridView.builder(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 6.w,
                                    vertical: 2.h,
                                  ),
                                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 3.h,
                                    crossAxisSpacing: 2.w,
                                    childAspectRatio: 9 / 13,
                                  ),
                                  itemCount: snapshotMemory.data!.toList().length,
                                  itemBuilder: (context, index) {
                                    return HomeMemoryItem(
                                      memory: snapshotMemory.data!.toList()[index],
                                      index: index,
                                      user: userEntity,
                                      isLoading:
                                          state.indexLoading == null ? false : state.indexLoading == index,
                                    );
                                  },
                                );
                              }
                              return const SizedBox();
                            }),
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<int> getNumers(int max) {
    List<int> list = [
      0,
    ];
    for (var i = 0; i < max; i++) {
      if (i % 2 == 0) {
        list.add(list.last + 3);
      } else {
        list.add(list.last + 1);
      }
    }

    return list;
  }
}

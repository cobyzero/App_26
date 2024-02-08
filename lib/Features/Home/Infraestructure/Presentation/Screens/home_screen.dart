import 'package:app_26/Core/Dependencies/injector.dart';
import 'package:app_26/Core/Static/colors.dart';
import 'package:app_26/Core/Static/texts.dart';
import 'package:app_26/Core/Util/util.dart';
import 'package:app_26/Core/Widgets/custom_button.dart';
import 'package:app_26/Features/Auth/Domain/Entities/user_entity.dart';
import 'package:app_26/Features/Home/Application/bloc/home_bloc.dart';
import 'package:app_26/Features/Home/Domain/Entities/memory_entity.dart';
import 'package:app_26/Features/Home/Domain/Repositories/home_repository.dart';
import 'package:app_26/Features/Home/Infraestructure/Presentation/Widgets/home_memory_item.dart';
import 'package:app_26/Features/Memory/Infraestructure/Presentation/Widgets/memory_title.dart';
import 'package:app_26/Features/User/Application/bloc/user_bloc.dart';
import 'package:easy_padding/easy_padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is UserComplete) {
          return StreamBuilder<UserEntity>(
              stream: state.user,
              builder: (context, snapshotUser) {
                if (snapshotUser.hasData) {
                  return BlocProvider(
                    create: (context) => HomeBloc(getIt.get<HomeRepository>())
                      ..add(
                        HomeEventGetMemorys(snapshotUser.data!.id),
                      ),
                    child: Scaffold(
                      floatingActionButtonLocation: ExpandableFab.location,
                      floatingActionButton: ExpandableFab(
                        children: [
                          FloatingActionButton(
                            heroTag: null,
                            child: const Icon(Icons.add),
                            onPressed: () {
                              context.go(
                                "/memoryCreate",
                                extra: snapshotUser.data!,
                              );
                            },
                          ),
                          FloatingActionButton(
                            heroTag: null,
                            child: const Icon(Icons.person),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    content: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          CustomButton(
                                            child: const Texts.regular(
                                              text: "Cerrar Sesión",
                                              color: Palette.grey,
                                            ),
                                            onTap: () {
                                              context.go("/login");
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                      body: SafeArea(
                          child: SizedBox.expand(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Texts.bold(
                                  text: "26 Recuerdos",
                                  fontSize: 20.sp,
                                  color: Palette.kPrimary,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.vpn_key,
                                      color: Colors.yellow,
                                      size: 20.sp,
                                    ).only(right: 10),
                                    Texts.bold(
                                      text: snapshotUser.data!.keys.toString(),
                                      alignment: TextAlign.center,
                                      color: Palette.kPrimary,
                                      fontSize: 15.sp,
                                    ),
                                  ],
                                ),
                              ],
                            ).all(5.w),
                            MemoryTitle(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Texts.bold(
                                        text: "Hola ${snapshotUser.data!.name}!",
                                        alignment: TextAlign.center,
                                        color: Palette.kPrimary,
                                      ),
                                    ],
                                  ).only(bottom: 10),
                                  Texts.regular(
                                    text: "Elige un recuerdo y descubre",
                                    fontSize: 10.sp,
                                    alignment: TextAlign.center,
                                    color: Palette.white,
                                  ),
                                ],
                              ),
                            ).symmetric(horizontal: 3.w),
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
                                                horizontal: 4.w,
                                                vertical: 2.h,
                                              ),
                                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                                crossAxisCount: 2,
                                                crossAxisSpacing: 5.w,
                                                mainAxisSpacing: 2.h,
                                                childAspectRatio: 9 / 16,
                                              ),
                                              itemCount: snapshotMemory.data!.toList().length,
                                              itemBuilder: (context, index) {
                                                return HomeMemoryItem(
                                                  memory: snapshotMemory.data!.toList()[index],
                                                  index: index,
                                                  user: snapshotUser.data!,
                                                  isLoading: state.indexLoading == null
                                                      ? false
                                                      : state.indexLoading == index,
                                                ).only(top: 1.h);
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
                      )),
                    ),
                  );
                }
                return Scaffold(
                  body: Center(
                    child: Util.loadingWidget(),
                  ),
                );
              });
        }
        return Scaffold(
          body: Center(
            child: Util.loadingWidget(),
          ),
        );
      },
    );
  }
}

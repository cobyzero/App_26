import 'package:app_26/Core/Dependencies/injector.dart';
import 'package:app_26/Core/Static/colors.dart';
import 'package:app_26/Core/Static/texts.dart';
import 'package:app_26/Core/Util/util.dart';
import 'package:app_26/Core/Widgets/custom_button.dart';
import 'package:app_26/Features/Auth/Application/bloc/login_bloc.dart';
import 'package:app_26/Features/Auth/Domain/Entities/user_entity.dart';
import 'package:app_26/Features/Home/Application/bloc/home_bloc.dart';
import 'package:app_26/Features/Home/Domain/Entities/memory_entity.dart';
import 'package:app_26/Features/Home/Domain/Repositories/home_repository.dart';
import 'package:app_26/Features/Home/Infraestructure/Presentation/Widgets/home_memory_item.dart';
import 'package:easy_padding/easy_padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = (context.read<LoginBloc>().state as LoginComplete).user;
    return StreamBuilder<UserEntity>(
        stream: user,
        builder: (context, snapshotUser) {
          if (snapshotUser.hasData) {
            return BlocProvider(
              create: (context) => HomeBloc(getIt.get<HomeRepository>())
                ..add(
                  HomeEventGetMemorys(snapshotUser.data!.id),
                ),
              child: Scaffold(
                floatingActionButton: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Texts.bold(
                            text: "Obtener llaves",
                            color: Palette.white,
                          ).only(right: 10),
                          const Icon(
                            Icons.vpn_key,
                            color: Colors.yellow,
                          )
                        ],
                      ),
                      onTap: () {
                        context.go("/questions", extra: snapshotUser.data!.id);
                      },
                    ),
                    CustomButton(
                      child: const Icon(
                        Icons.logout,
                        color: Colors.white,
                      ),
                      onTap: () {
                        context.go("/login");
                      },
                    ),
                  ],
                ).all(20),
                floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
                body: SafeArea(
                    child: SizedBox.expand(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 5.w,
                          vertical: 3.h,
                        ),
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          color: Palette.kPrimary,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(40),
                            bottomRight: Radius.circular(40),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Texts.bold(
                                  text: "Hola ${snapshotUser.data!.name}!",
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
                                      text: snapshotUser.data!.keys.toString(),
                                      alignment: TextAlign.center,
                                      color: Palette.grey,
                                    ),
                                  ],
                                )
                              ],
                            ).only(bottom: 10),
                            Texts.regular(
                              text: "Elige un recuerdo y descubre",
                              fontSize: 10.sp,
                              alignment: TextAlign.center,
                              color: Palette.grey,
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
                                      return GridView.builder(
                                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3,
                                          crossAxisSpacing: 10.w,
                                          mainAxisSpacing: 2.h,
                                          childAspectRatio: 1.4,
                                        ),
                                        itemCount: snapshotMemory.data!.toList().length,
                                        itemBuilder: (context, index) {
                                          return HomeMemoryItem(
                                            memory: snapshotMemory.data!.toList()[index],
                                            index: index,
                                            user: snapshotUser.data!,
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
}

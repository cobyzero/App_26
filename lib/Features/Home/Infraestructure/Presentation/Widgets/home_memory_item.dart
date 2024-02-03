import 'package:app_26/Core/Static/colors.dart';
import 'package:app_26/Core/Static/texts.dart';
import 'package:app_26/Core/Util/util.dart';
import 'package:app_26/Features/Auth/Domain/Entities/user_entity.dart';
import 'package:app_26/Features/Home/Application/bloc/home_bloc.dart';
import 'package:app_26/Features/Home/Domain/Entities/memory_entity.dart';
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
  });
  final int index;
  final MemoryEntity memory;
  final UserEntity user;
  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: () {
        if (memory.isBlocked) {
          if (user.keys == 0) {
            Util.showMessage("No cuentas con llaves suficientes", context);
            return;
          }

          context.read<HomeBloc>().add(
                HomeEventUnlockMemory(
                  memory.id,
                  userId: user.id,
                  keys: user.keys,
                ),
              );
          return;
        }
        context.go("/memory", extra: memory);
      },
      style: FilledButton.styleFrom(
        shape: const CircleBorder(
          side: BorderSide(
            width: 4,
            color: Palette.grey,
          ),
        ),
        elevation: 20,
        shadowColor: Palette.kPrimary,
        backgroundColor: Palette.kPrimary,
      ),
      child: memory.isBlocked
          ? Icon(
              Icons.lock,
              color: Colors.white,
              size: 16.sp,
            )
          : Texts.bold(
              text: (index + 1).toString(),
              fontSize: 6.sp,
              color: Palette.white,
            ),
    );
  }
}

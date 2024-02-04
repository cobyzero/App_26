import 'package:app_26/Core/Static/colors.dart';
import 'package:app_26/Core/Static/texts.dart';
import 'package:app_26/Core/Widgets/custom_button.dart';
import 'package:app_26/Features/Auth/Application/bloc/login_bloc.dart';
import 'package:easy_padding/easy_padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomeAdminScreen extends StatelessWidget {
  const HomeAdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: CustomButton(
        child: const Icon(
          Icons.logout,
          color: Colors.white,
        ),
        onTap: () {
          context.go("/login");
        },
      ).all(20),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: SafeArea(
          child: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(
              child: const Texts.bold(
                text: "Crear memoria",
                color: Palette.white,
              ),
              onTap: () async {
                await (context.read<LoginBloc>().state as LoginComplete).user.first.then(
                      (value) => context.go("/memoryCreate", extra: value.id),
                    );
              },
            ),
          ],
        ),
      )),
    );
  }
}

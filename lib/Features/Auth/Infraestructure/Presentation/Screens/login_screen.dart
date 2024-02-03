import 'package:app_26/Core/Static/assets.dart';
import 'package:app_26/Core/Static/colors.dart';
import 'package:app_26/Core/Static/const.dart';
import 'package:app_26/Core/Util/util.dart';
import 'package:app_26/Core/Widgets/custom_input.dart';
import 'package:app_26/Features/Auth/Application/bloc/login_bloc.dart';
import 'package:easy_padding/easy_padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final TextEditingController keyController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginComplete) {
          GoRouter.of(context).pop();

          state.user.first.then((value) {
            if (value.rol == Rol.admin.index) {
              context.go("/homeAdmin");
            } else if (value.rol == Rol.user.index) {
              context.go("/home");
            }
          });
        } else if (state is LoginError) {
          GoRouter.of(context).pop();
          Util.showMessage(state.error, context);
          keyController.text = "";
          context.read<LoginBloc>().add(
                LoginEventSetEmpty(isEmpty: true),
              );
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: SizedBox.expand(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "${assetImage}love-and-romance.png",
                  width: 40.w,
                  height: 40.w,
                ),
                Form(
                  key: formKey,
                  child: CustomInput(
                    onChanged: (p0) => context.read<LoginBloc>().add(
                          LoginEventSetEmpty(isEmpty: p0.isEmpty),
                        ),
                    validator: (p0) => p0!.isEmpty ? "Rellene el campo" : null,
                    controller: keyController,
                    hintText: "Key",
                    suffixIcon: IconButton(
                      onPressed: () {
                        if (!formKey.currentState!.validate()) return;
                        Util.loading(context);
                        context.read<LoginBloc>().add(
                              LoginEventLogin(key: keyController.text),
                            );
                      },
                      icon: BlocBuilder<LoginBloc, LoginState>(
                        builder: (context, state) {
                          if (state is LoginInitial) {
                            return Icon(
                              Icons.arrow_circle_right_outlined,
                              size: 20.sp,
                              color: state.isEmpty ? Palette.grey2 : Palette.kPrimary,
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    ),
                  ).symmetric(horizontal: 10.w, vertical: 10.h),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

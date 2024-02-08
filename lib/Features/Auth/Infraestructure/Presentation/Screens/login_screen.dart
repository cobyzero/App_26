import 'package:app_26/Core/Static/assets.dart';
import 'package:app_26/Core/Static/colors.dart';
import 'package:app_26/Core/Static/texts.dart';
import 'package:app_26/Core/Util/util.dart';
import 'package:app_26/Core/Widgets/custom_button.dart';
import 'package:app_26/Core/Widgets/custom_input.dart';
import 'package:app_26/Features/Auth/Application/bloc/login_bloc.dart';
import 'package:app_26/Features/User/Application/bloc/user_bloc.dart';
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
          context.read<UserBloc>().add(UserEventGetUser(state.userId));
          context.go("/home");
        } else if (state is LoginError) {
          GoRouter.of(context).pop();
          Util.showError(
            text: state.error,
            context: context,
            onConfirm: () {},
          );

          keyController.text = "";
          context.read<LoginBloc>().add(
                LoginEventSetEmpty(isEmpty: true),
              );
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("${assetImage}background.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 17.h,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 10.w,
                    ),
                    width: double.infinity,
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: Palette.white,
                    ),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          Container(
                            width: 30.w,
                            height: 30.w,
                            padding: const EdgeInsets.all(20),
                            decoration: const BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  offset: Offset.zero,
                                  color: Palette.kPrimary,
                                  blurRadius: 13,
                                ),
                              ],
                              shape: BoxShape.circle,
                              color: Palette.kPrimary,
                            ),
                            child: Image.asset(
                              "${assetImage}love-and-romance.png",
                            ),
                          ).only(bottom: 8.h),
                          const Texts.bold(
                            text: "Ingrese su key",
                          ).only(bottom: 6.h),
                          CustomInput(
                            validator: (p0) => p0!.isEmpty ? "Rellene el campo" : null,
                            controller: keyController,
                            hintText: "Key",
                          ).only(bottom: 6.h),
                          CustomButton(
                            child: const Texts.regular(
                              text: "Ingresar",
                              color: Palette.white,
                            ),
                            onTap: () {
                              if (!formKey.currentState!.validate()) return;
                              Util.loading(context);
                              context.read<LoginBloc>().add(
                                    LoginEventLogin(key: keyController.text),
                                  );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 17.h,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

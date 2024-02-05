import 'package:app_26/Core/Static/assets.dart';
import 'package:app_26/Core/Static/colors.dart';
import 'package:app_26/Core/Static/const.dart';
import 'package:app_26/Core/Static/texts.dart';
import 'package:app_26/Core/Util/util.dart';
import 'package:app_26/Core/Widgets/custom_button.dart';
import 'package:app_26/Core/Widgets/custom_input.dart';
import 'package:app_26/Features/Auth/Application/bloc/login_bloc.dart';
import 'package:easy_padding/easy_padding.dart';
import 'package:flutter/gestures.dart';
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
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("${assetImage}background.jpg"),
                fit: BoxFit.cover,
              ),
            ),
            alignment: Alignment.bottomCenter,
            child: SingleChildScrollView(
              dragStartBehavior: DragStartBehavior.down,
              child: Column(
                children: [
                  SizedBox(
                    height: 30.h,
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(15.w),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                      color: Palette.white,
                    ),
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
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
                            child: Texts.regular(
                              padding: EdgeInsets.symmetric(horizontal: 23.w),
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

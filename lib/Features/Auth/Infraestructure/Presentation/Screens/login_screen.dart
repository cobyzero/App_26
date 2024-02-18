import 'package:app_26/Core/Static/assets.dart';
import 'package:app_26/Core/Static/colors.dart';
import 'package:app_26/Core/Static/texts.dart';
import 'package:app_26/Core/Util/util.dart';
import 'package:app_26/Features/Auth/Application/bloc/login_bloc.dart';
import 'package:app_26/Features/User/Application/bloc/user_bloc.dart';
import 'package:easy_padding/easy_padding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sizer/sizer.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginComplete) {
          GoRouter.of(context).pop();
          context.read<UserBloc>().add(UserEventGetUser(state.userId));
          context.go("/main");
        } else if (state is LoginError) {
          GoRouter.of(context).pop();
          Util.showError(
            text: state.error,
            context: context,
            onConfirm: () {},
          );

          context.read<LoginBloc>().add(
                LoginEventSetEmpty(isEmpty: true),
              );
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xffAAD1FD),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Image.asset(
                  "${assetImage}person.jpg",
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(
                        40,
                      ),
                      topRight: Radius.circular(
                        40,
                      ),
                    ),
                    color: Palette.white,
                    boxShadow: [
                      BoxShadow(
                        offset: Offset.zero,
                        color: Palette.grey2,
                        blurRadius: 13,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Texts.bold(
                        text: "26 Recuerdos",
                        fontSize: 20.sp,
                      ).only(bottom: 3.h),
                      Texts.bold(
                        text: "Bienvenido(a) denuevo!",
                        fontSize: 14.sp,
                      ).only(bottom: 2.h),
                      Texts.regular(
                        text: "Ingresa y descubre momentos increibles",
                        fontSize: 12.sp,
                      ).only(bottom: 4.h),
                      SignInButton(
                        Buttons.Google,
                        text: "Continuar con Google",
                        onPressed: () async {
                          final google = await GoogleSignIn().signIn();
                          if (google == null) return;
                          // ignore: use_build_context_synchronously
                          Util.loading(context);
                          // ignore: use_build_context_synchronously
                          context.read<LoginBloc>().add(
                                LoginEventLogin(google: google),
                              );
                        },
                        padding: EdgeInsets.symmetric(
                          horizontal: 4.w,
                          vertical: 1.h,
                        ),
                        shape: const StadiumBorder(),
                        elevation: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

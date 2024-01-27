import 'package:app_26/Core/Dependencies/injector.dart';
import 'package:app_26/Core/Static/assets.dart';
import 'package:app_26/Features/Splash/Application/bloc/splash_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt.get<SplashBloc>()..add(SplashEventInit()),
      child: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) {
          if (state is SplashComplete) {
            context.go("/home");
          }
        },
        child: Scaffold(
          body: Center(
            child: Image.asset(
              "${assetImage}love-and-romance.png",
              width: 40.w,
            ),
          ),
        ),
      ),
    );
  }
}

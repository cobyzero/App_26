import 'package:app_26/Core/Dependencies/injector.dart';
import 'package:app_26/Core/Routes/router.dart';
import 'package:app_26/Features/Auth/Application/bloc/login_bloc.dart';
import 'package:app_26/Features/Auth/Domain/Repositories/auth_repository.dart';
import 'package:app_26/Features/Memory/Application/Blocs/memory_create_bloc/memory_create_bloc.dart';
import 'package:app_26/Features/User/Application/bloc/user_bloc.dart';
import 'package:app_26/firebase_options.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAppCheck.instance.activate();

  await initDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginBloc(
            getIt.get<AuthRepository>(),
          ),
        ),
        BlocProvider(
          create: (context) => getIt.get<MemoryCreateBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt.get<UserBloc>(),
        )
      ],
      child: Sizer(
        builder: (context, orientation, deviceType) {
          return MaterialApp.router(
            title: '26 Recuerdos',
            routerConfig: goRouter,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(fontFamily: "SFPro"),
          );
        },
      ),
    );
  }
}

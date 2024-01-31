import 'package:app_26/Core/Dependencies/injector.dart';
import 'package:app_26/Core/Routes/router.dart';
import 'package:app_26/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp.router(
          title: 'Material App',
          routerConfig: goRouter,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(fontFamily: "Inter"),
        );
      },
    );
  }
}

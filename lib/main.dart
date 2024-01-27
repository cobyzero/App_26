import 'package:app_26/Core/Dependencies/injector.dart';
import 'package:app_26/Core/Routes/router.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

Future<void> main() async {
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

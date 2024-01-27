import 'package:app_26/Features/Splash/Application/bloc/splash_bloc.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.asNewInstance();

Future<void> initDependencies() async {
  getIt.registerLazySingleton<SplashBloc>(
    () => SplashBloc(),
  );
}

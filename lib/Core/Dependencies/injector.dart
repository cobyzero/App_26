import 'package:app_26/Features/Auth/Application/IRepositories/auth_repository.dart';
import 'package:app_26/Features/Auth/Application/Services/auth_service.dart';
import 'package:app_26/Features/Auth/Domain/Repositories/auth_repository.dart';
import 'package:app_26/Features/Splash/Application/bloc/splash_bloc.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.asNewInstance();

Future<void> initDependencies() async {
  getIt.registerLazySingleton<AuthService>(
    () => AuthService(),
  );

  getIt.registerLazySingleton<AuthRepository>(
    () => IAuthRepository(
      getIt.get<AuthService>(),
    ),
  );

  getIt.registerLazySingleton<SplashBloc>(
    () => SplashBloc(),
  );
}

import 'package:app_26/Features/Auth/Application/IRepositories/auth_repository.dart';
import 'package:app_26/Features/Auth/Application/Services/auth_service.dart';
import 'package:app_26/Features/Auth/Domain/Repositories/auth_repository.dart';
import 'package:app_26/Features/Home/Application/IRepositories/home_repository.dart';
import 'package:app_26/Features/Home/Application/Services/home_services.dart';
import 'package:app_26/Features/Home/Domain/Repositories/home_repository.dart';
import 'package:app_26/Features/Questions/Application/IRepositories/questions_repository.dart';
import 'package:app_26/Features/Questions/Application/Services/questions_service.dart';
import 'package:app_26/Features/Questions/Domain/Repositories/questions_repository.dart';
import 'package:app_26/Features/Splash/Application/bloc/splash_bloc.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.asNewInstance();

Future<void> initDependencies() async {
  //SERVICES
  getIt.registerLazySingleton<AuthService>(
    () => AuthService(),
  );
  getIt.registerLazySingleton<HomeServices>(
    () => HomeServices(),
  );
  getIt.registerLazySingleton<QuestionService>(
    () => QuestionService(),
  );
  //REPOSITORIES
  getIt.registerLazySingleton<AuthRepository>(
    () => IAuthRepository(
      getIt.get<AuthService>(),
    ),
  );
  getIt.registerLazySingleton<HomeRepository>(
    () => IHomeRepository(
      getIt.get<HomeServices>(),
    ),
  );
  getIt.registerLazySingleton<QuestionRepository>(
    () => IQuestionRepository(
      getIt.get<QuestionService>(),
    ),
  );
  //BLOCS
  getIt.registerLazySingleton<SplashBloc>(
    () => SplashBloc(),
  );
}

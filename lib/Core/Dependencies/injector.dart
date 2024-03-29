import 'package:app_26/Features/Auth/Application/IRepositories/auth_repository.dart';
import 'package:app_26/Features/Auth/Application/Services/auth_service.dart';
import 'package:app_26/Features/Auth/Domain/Repositories/auth_repository.dart';
import 'package:app_26/Features/Home/Application/IRepositories/home_repository.dart';
import 'package:app_26/Features/Home/Application/Services/home_services.dart';
import 'package:app_26/Features/Home/Domain/Repositories/home_repository.dart';
import 'package:app_26/Features/Memory/Application/Blocs/memory_create_bloc/memory_create_bloc.dart';
import 'package:app_26/Features/Memory/Application/Repositories/memory_repository.dart';
import 'package:app_26/Features/Memory/Application/Services/memory_service.dart';
import 'package:app_26/Features/Memory/Domain/Repositories/memory_repository.dart';
import 'package:app_26/Features/Questions/Application/IRepositories/questions_repository.dart';
import 'package:app_26/Features/Questions/Application/Services/questions_service.dart';
import 'package:app_26/Features/Questions/Domain/Repositories/questions_repository.dart';
import 'package:app_26/Features/Splash/Application/bloc/splash_bloc.dart';
import 'package:app_26/Features/User/Application/Repositories/user_repository.dart';
import 'package:app_26/Features/User/Application/Services/user_service.dart';
import 'package:app_26/Features/User/Application/bloc/user_bloc.dart';
import 'package:app_26/Features/User/Domain/Repositories/user_repository.dart';
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
  getIt.registerLazySingleton<MemoryService>(
    () => MemoryService(),
  );
  getIt.registerLazySingleton<UserService>(
    () => UserService(),
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
  getIt.registerLazySingleton<MemoryRepository>(
    () => IMemoryRepository(
      getIt.get<MemoryService>(),
    ),
  );
  getIt.registerLazySingleton<UserRepository>(
    () => IUserRepository(
      getIt.get<UserService>(),
    ),
  );
  //BLOCS
  getIt.registerLazySingleton<SplashBloc>(
    () => SplashBloc(),
  );
  getIt.registerLazySingleton<MemoryCreateBloc>(
    () => MemoryCreateBloc(
      getIt.get<MemoryRepository>(),
    ),
  );
  getIt.registerLazySingleton<UserBloc>(
    () => UserBloc(
      getIt.get<UserRepository>(),
    ),
  );
}

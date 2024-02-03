import 'package:app_26/Features/Auth/Application/Services/auth_service.dart';
import 'package:app_26/Features/Auth/Domain/Entities/user_entity.dart';
import 'package:app_26/Features/Auth/Domain/Repositories/auth_repository.dart';

class IAuthRepository extends AuthRepository {
  final AuthService service;

  IAuthRepository(this.service);

  @override
  Stream<UserEntity> login(String key) {
    try {
      final data = service.login(key);
      return data.map(
        (event) {
          return UserEntity.fromJson(event.docs.first.data());
        },
      );
    } catch (e) {
      throw Exception("Error al mapear user");
    }
  }
}

import 'package:app_26/Features/Auth/Application/Services/auth_service.dart';
import 'package:app_26/Features/Auth/Domain/Repositories/auth_repository.dart';

class IAuthRepository extends AuthRepository {
  final AuthService service;

  IAuthRepository(this.service);

  @override
  Future<String> login(String key) async {
    try {
      final data = await service.login(key);

      return data.docs.first.id;
    } catch (e) {
      throw "Ingrese una key valida";
    }
  }
}

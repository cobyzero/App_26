import 'package:app_26/Features/Auth/Application/Services/auth_service.dart';
import 'package:app_26/Features/Auth/Domain/Repositories/auth_repository.dart';
import 'package:google_sign_in/google_sign_in.dart';

class IAuthRepository extends AuthRepository {
  final AuthService service;

  IAuthRepository(this.service);

  @override
  Future<String> login(GoogleSignInAccount key) async {
    try {
      return await service.login(key);
    } catch (e) {
      throw "Ingrese una key valida";
    }
  }
}

import 'package:app_26/Features/Auth/Domain/Entities/user_entity.dart';

abstract class AuthRepository {
  Stream<UserEntity> login(String key);
}

import 'package:app_26/Features/Auth/Domain/Entities/user_entity.dart';

abstract class UserRepository {
  Stream<UserEntity> getUser(String userId);
}

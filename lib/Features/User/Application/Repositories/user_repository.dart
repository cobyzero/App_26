import 'package:app_26/Features/Auth/Domain/Entities/user_entity.dart';
import 'package:app_26/Features/User/Application/Services/user_service.dart';
import 'package:app_26/Features/User/Domain/Repositories/user_repository.dart';

class IUserRepository extends UserRepository {
  final UserService service;

  IUserRepository(this.service);
  @override
  Stream<UserEntity> getUser(String userId) {
    final data = service.getUser(userId);

    return data.map(
      (event) => UserEntity.fromJson(event.docs.first.data()),
    );
  }
}

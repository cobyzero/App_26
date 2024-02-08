import 'package:app_26/Features/Auth/Domain/Entities/user_entity.dart';
import 'package:app_26/Features/User/Domain/Repositories/user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository repository;

  UserBloc(this.repository) : super(UserInitial()) {
    on<UserEventGetUser>((event, emit) async {
      try {
        final user = repository.getUser(event.userId);

        emit(
          UserComplete(user: user),
        );
      } catch (e) {
        emit(
          UserError(error: e.toString()),
        );
      }
    });
  }
}

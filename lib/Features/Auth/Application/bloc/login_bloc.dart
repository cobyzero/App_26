import 'package:app_26/Features/Auth/Domain/Repositories/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository repository;

  LoginBloc(this.repository) : super(LoginInitial(isEmpty: true)) {
    on<LoginEventSetEmpty>((event, emit) {
      emit(LoginInitial(isEmpty: event.isEmpty));
    });

    on<LoginEventLogin>((event, emit) async {
      try {
        final id = await repository.login(event.key);
        emit(
          LoginComplete(id: id),
        );
      } catch (e) {
        emit(
          LoginError(error: e.toString()),
        );
      }
    });
  }
}

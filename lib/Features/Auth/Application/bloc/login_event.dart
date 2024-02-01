part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

class LoginEventSetEmpty extends LoginEvent {
  final bool isEmpty;

  LoginEventSetEmpty({required this.isEmpty});
}

class LoginEventLogin extends LoginEvent {
  final String key;

  LoginEventLogin({required this.key});
}

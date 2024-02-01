part of 'login_bloc.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {
  final bool isEmpty;

  LoginInitial({required this.isEmpty});

  copyWith({bool? isEmpty}) {
    return LoginInitial(
      isEmpty: isEmpty ?? this.isEmpty,
    );
  }
}

final class LoginComplete extends LoginState {
  final String id;

  LoginComplete({required this.id});

  copyWith({String? id}) {
    return LoginComplete(
      id: id ?? this.id,
    );
  }
}

final class LoginError extends LoginState {
  final String error;

  LoginError({required this.error});
}

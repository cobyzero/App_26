part of 'user_bloc.dart';

@immutable
sealed class UserState {}

final class UserInitial extends UserState {}

final class UserComplete extends UserState {
  final Stream<UserEntity> user;

  UserComplete({required this.user});

  copyWith({Stream<UserEntity>? user}) {
    return UserComplete(
      user: user ?? this.user,
    );
  }
}

final class UserError extends UserState {
  final String error;

  UserError({required this.error});
}

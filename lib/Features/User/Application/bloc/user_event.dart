part of 'user_bloc.dart';

@immutable
sealed class UserEvent {}

class UserEventGetUser extends UserEvent {
  final String userId;

  UserEventGetUser(this.userId);
}

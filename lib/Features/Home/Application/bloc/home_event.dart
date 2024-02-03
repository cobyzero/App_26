part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class HomeEventGetMemorys extends HomeEvent {
  final String userId;

  HomeEventGetMemorys(this.userId);
}

class HomeEventUnlockMemory extends HomeEvent {
  final String userId;
  final int keys;
  final String memoryId;
  HomeEventUnlockMemory(
    this.memoryId, {
    required this.userId,
    required this.keys,
  });
}

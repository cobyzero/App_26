part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

class HomeComplete extends HomeState {
  final Stream<Iterable<MemoryEntity>> memorys;

  HomeComplete({required this.memorys});

  copyWith({
    Stream<Iterable<MemoryEntity>>? memorys,
  }) {
    return HomeComplete(
      memorys: memorys ?? this.memorys,
    );
  }
}

final class HomeError extends HomeState {
  final String error;

  HomeError({required this.error});
}

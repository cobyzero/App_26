part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

class HomeComplete extends HomeState {
  final Stream<Iterable<MemoryEntity>> memorys;
  final int? indexLoading;
  HomeComplete({
    required this.memorys,
    this.indexLoading,
  });

  copyWith({
    Stream<Iterable<MemoryEntity>>? memorys,
    int? indexLoading,
  }) {
    return HomeComplete(
      memorys: memorys ?? this.memorys,
      indexLoading: indexLoading ?? this.indexLoading,
    );
  }
}

final class HomeError extends HomeState {
  final String error;

  HomeError({required this.error});
}

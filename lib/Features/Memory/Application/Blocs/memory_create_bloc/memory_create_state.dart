part of 'memory_create_bloc.dart';

@immutable
sealed class MemoryCreateState {}

final class MemoryCreateInitial extends MemoryCreateState {
  final String? image;
  final String? pathImage;
  final bool isBlocked;
  final DateTime? date;
  MemoryCreateInitial({
    this.image,
    this.date,
    this.isBlocked = false,
    this.pathImage,
  });

  copyWith({
    String? image,
    String? pathImage,
    bool? isBlocked,
    DateTime? date,
  }) {
    return MemoryCreateInitial(
      date: date ?? this.date,
      image: image ?? this.image,
      pathImage: pathImage ?? this.pathImage,
      isBlocked: isBlocked ?? this.isBlocked,
    );
  }
}

class MemoryCreateComplete extends MemoryCreateState {}

class MemoryCreateError extends MemoryCreateState {
  final String error;

  MemoryCreateError(this.error);
}

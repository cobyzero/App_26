part of 'memory_create_bloc.dart';

@immutable
sealed class MemoryCreateState {}

final class MemoryCreateInitial extends MemoryCreateState {
  final List<String> image;
  final List<String> pathImage;
  final bool isBlocked;
  final DateTime date;
  final bool? isKeyValided;
  final bool loadingKey;
  final TextEditingController messageController;
  final TextEditingController keyUserController;

  MemoryCreateInitial({
    this.image = const [],
    required this.date,
    this.isBlocked = false,
    this.pathImage = const [],
    this.isKeyValided,
    this.loadingKey = false,
    required this.keyUserController,
    required this.messageController,
  });

  copyWith({
    List<String>? image,
    List<String>? pathImage,
    bool? isBlocked,
    DateTime? date,
    bool? isKeyValided,
    bool? loadingKey,
    TextEditingController? messageController,
    TextEditingController? keyUserController,
  }) {
    return MemoryCreateInitial(
      date: date ?? this.date,
      image: image ?? this.image,
      pathImage: pathImage ?? this.pathImage,
      isBlocked: isBlocked ?? this.isBlocked,
      isKeyValided: isKeyValided,
      loadingKey: loadingKey ?? this.loadingKey,
      messageController: messageController ?? this.messageController,
      keyUserController: keyUserController ?? this.keyUserController,
    );
  }
}

class MemoryCreateComplete extends MemoryCreateState {}

class MemoryCreateError extends MemoryCreateState {
  final String error;

  MemoryCreateError(this.error);
}

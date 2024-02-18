part of 'memory_bloc.dart';

class MemoryState {
  final bool isOpen;
  final List<String> images;

  const MemoryState({
    this.isOpen = false,
    this.images = const [],
  });

  copyWith({
    List<String>? images,
    bool? isOpen,
    bool? isLoaded,
  }) {
    return MemoryState(
      images: images ?? this.images,
      isOpen: isOpen ?? this.isOpen,
    );
  }
}

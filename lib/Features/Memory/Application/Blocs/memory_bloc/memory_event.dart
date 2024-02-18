part of 'memory_bloc.dart';

@immutable
sealed class MemoryEvent {}

class MemoryEventOpen extends MemoryEvent {}

class MemoryEventLoadedImages extends MemoryEvent {
  final List<String> images;
  final String userId;
  MemoryEventLoadedImages(this.images, this.userId);
}

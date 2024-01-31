part of 'memory_bloc.dart';

@immutable
class MemoryState {
  final bool isOpen;

  const MemoryState({required this.isOpen});
}

final class MemoryInitial extends MemoryState {
  const MemoryInitial({required super.isOpen});
}

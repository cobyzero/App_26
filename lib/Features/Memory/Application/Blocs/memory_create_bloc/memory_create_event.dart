part of 'memory_create_bloc.dart';

@immutable
sealed class MemoryCreateEvent {}

class MemoryCreateSetImage extends MemoryCreateEvent {
  final String image;
  final String pathImage;
  MemoryCreateSetImage(this.image, this.pathImage);
}

class MemoryCreateSetIsBlocked extends MemoryCreateEvent {
  final bool isBlocked;

  MemoryCreateSetIsBlocked(this.isBlocked);
}

class MemoryCreateSetDate extends MemoryCreateEvent {
  final DateTime date;

  MemoryCreateSetDate(this.date);
}

class MemoryCreateCreate extends MemoryCreateEvent {
  final String keyUser;
  final String message;
  MemoryCreateCreate(this.keyUser, this.message);
}

class MemoryCreateClean extends MemoryCreateEvent {}

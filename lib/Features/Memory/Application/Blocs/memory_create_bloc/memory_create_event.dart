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
  final String nameUser;
  MemoryCreateCreate(this.keyUser, this.message, this.nameUser);
}

class MemoryCreateClean extends MemoryCreateEvent {}

class MemoryCreateValidateKey extends MemoryCreateEvent {
  final String key;

  MemoryCreateValidateKey(this.key);
}

class MemoryCreateCleanKeyValidate extends MemoryCreateEvent {}

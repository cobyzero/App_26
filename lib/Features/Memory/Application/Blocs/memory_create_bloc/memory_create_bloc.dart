import 'package:app_26/Features/Memory/Domain/Entities/memory_create_entity.dart';
import 'package:app_26/Features/Memory/Domain/Repositories/memory_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'memory_create_event.dart';
part 'memory_create_state.dart';

class MemoryCreateBloc extends Bloc<MemoryCreateEvent, MemoryCreateState> {
  final MemoryRepository repository;

  MemoryCreateBloc(this.repository)
      : super(MemoryCreateInitial(
          date: DateTime.now(),
          keyUserController: TextEditingController(),
          messageController: TextEditingController(),
        )) {
    on<MemoryCreateSetImage>((event, emit) {
      final nState = (state as MemoryCreateInitial);
      var nImage = [...nState.image, event.image];
      var nPath = [...nState.pathImage, event.pathImage];

      emit(nState.copyWith(image: nImage, pathImage: nPath));
    });

    on<MemoryCreateSetIsBlocked>((event, emit) {
      final nState = (state as MemoryCreateInitial);

      emit(nState.copyWith(isBlocked: event.isBlocked));
    });

    on<MemoryCreateSetDate>((event, emit) {
      final nState = (state as MemoryCreateInitial);

      emit(nState.copyWith(date: event.date));
    });

    on<MemoryCreateCreate>((event, emit) async {
      final nState = (state as MemoryCreateInitial);

      final entity = MemoryCreateEntity(
          date: nState.date.toIso8601String(),
          isBlocked: nState.isBlocked,
          message: event.message,
          image: nState.image,
          userId: "",
          pathImage: nState.pathImage,
          nameUser: event.nameUser);

      try {
        await repository.createMemory(entity, event.keyUser);
        emit(MemoryCreateComplete());
      } catch (e) {
        emit(MemoryCreateError(e.toString()));
      }
    });

    on<MemoryCreateClean>((event, emit) {
      emit(MemoryCreateInitial(
        date: DateTime.now(),
        isKeyValided: null,
        keyUserController: TextEditingController(),
        messageController: TextEditingController(),
      ));
    });

    on<MemoryCreateValidateKey>((event, emit) async {
      try {
        final nState = (state as MemoryCreateInitial);
        emit(nState.copyWith(loadingKey: true, isKeyValided: null));
        final validate = await repository.validatedKey(event.key);
        emit(
          nState.copyWith(
            isKeyValided: validate,
            loadingKey: false,
          ),
        );
      } catch (e) {
        emit(MemoryCreateError(e.toString()));
      }
    });

    on<MemoryCreateCleanKeyValidate>((event, emit) async {
      final nState = (state as MemoryCreateInitial);
      emit(nState.copyWith(isKeyValided: null));
    });
  }
}

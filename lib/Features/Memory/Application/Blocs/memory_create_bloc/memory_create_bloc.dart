import 'package:app_26/Features/Memory/Domain/Entities/memory_create_entity.dart';
import 'package:app_26/Features/Memory/Domain/Repositories/memory_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'memory_create_event.dart';
part 'memory_create_state.dart';

class MemoryCreateBloc extends Bloc<MemoryCreateEvent, MemoryCreateState> {
  final MemoryRepository repository;

  MemoryCreateBloc(this.repository)
      : super(MemoryCreateInitial(
          date: DateTime.now(),
        )) {
    on<MemoryCreateSetImage>((event, emit) {
      final nState = (state as MemoryCreateInitial);

      emit(nState.copyWith(image: event.image, pathImage: event.pathImage));
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
        image: nState.image!,
        userId: event.keyUser,
      );

      try {
        await repository.createMemory(entity, nState.pathImage!);
        emit(MemoryCreateComplete());
      } catch (e) {
        emit(MemoryCreateError(e.toString()));
      }
    });

    on<MemoryCreateClean>((event, emit) {
      emit(MemoryCreateInitial(
        date: DateTime.now(),
      ));
    });
  }
}

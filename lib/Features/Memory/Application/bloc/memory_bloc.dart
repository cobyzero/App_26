import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'memory_event.dart';
part 'memory_state.dart';

class MemoryBloc extends Bloc<MemoryEvent, MemoryState> {
  MemoryBloc() : super(const MemoryInitial(isOpen: false)) {
    on<MemoryEventOpen>((event, emit) {
      emit(MemoryInitial(isOpen: !state.isOpen));
    });
  }
}

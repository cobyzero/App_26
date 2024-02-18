import 'package:app_26/Core/Util/util.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'memory_event.dart';
part 'memory_state.dart';

class MemoryBloc extends Bloc<MemoryEvent, MemoryState> {
  MemoryBloc() : super(const MemoryState()) {
    on<MemoryEventLoadedImages>((event, emit) async {
      final list = <String>[];

      for (var element in event.images) {
        list.add(await Util.getImage(event.userId, element));
      }

      emit(state.copyWith(images: list));
    });
    on<MemoryEventOpen>((event, emit) {
      emit(state.copyWith(
        isOpen: !state.isOpen,
      ));
    });
  }
}

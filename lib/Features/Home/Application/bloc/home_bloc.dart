import 'dart:async';

import 'package:app_26/Features/Home/Domain/Entities/memory_entity.dart';
import 'package:app_26/Features/Home/Domain/Repositories/home_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository repository;
  HomeBloc(this.repository) : super(HomeInitial()) {
    on<HomeEventGetMemorys>((event, emit) async {
      try {
        final memorys = repository.getMemorys(event.userId);
        emit(HomeComplete(memorys: memorys));
      } catch (e) {
        emit(HomeError(error: e.toString()));
      }
    });

    on<HomeEventUnlockMemory>((event, emit) async {
      try {
        final nState = (state as HomeComplete);

        emit(nState.copyWith(indexLoading: event.index));

        await repository.unlockMemory(event.userId, event.keys, event.memoryId).whenComplete(
              () => emit(
                nState.copyWith(indexLoading: null),
              ),
            );
      } catch (e) {
        emit(HomeError(error: e.toString()));
      }
    });
  }
}

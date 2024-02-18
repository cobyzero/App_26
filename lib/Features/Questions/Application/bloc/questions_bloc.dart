import 'package:app_26/Features/Questions/Domain/Entities/question_entity.dart';
import 'package:app_26/Features/Questions/Domain/Repositories/questions_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'questions_event.dart';
part 'questions_state.dart';

class QuestionsBloc extends Bloc<QuestionsEvent, QuestionsState> {
  final QuestionRepository repository;
  QuestionsBloc(this.repository) : super(QuestionsInitial()) {
    on<QuestionsEventGet>((event, emit) async {
      try {
        final questions = await repository.getQuestions(event.userId);

        emit(
          QuestionComplete(
            questions: questions,
            index: 0,
            isSelected: null,
          ),
        );
      } catch (e) {
        emit(QuestionError(e.toString()));
      }
    });

    on<QuestionEventSetSelected>((event, emit) async {
      try {
        final nState = (state as QuestionComplete);
        emit(
          nState.copyWith(isSelected: event.index),
        );
      } catch (e) {
        emit(QuestionError(e.toString()));
      }
    });

    on<QuestionEventCheckQuestion>((event, emit) async {
      try {
        final nState = (state as QuestionComplete);

        await repository.checkQuestion(event.questionId, event.userId);

        emit(
          nState.copyWith(isSelected: null, index: nState.index + 1),
        );
      } catch (e) {
        emit(QuestionError(e.toString()));
      }
    });
  }
}

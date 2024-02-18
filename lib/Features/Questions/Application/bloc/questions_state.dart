part of 'questions_bloc.dart';

@immutable
sealed class QuestionsState {}

final class QuestionsInitial extends QuestionsState {}

class QuestionComplete extends QuestionsState {
  final List<QuestionEntity> questions;
  final int index;
  final int? isSelected;

  QuestionComplete({
    required this.isSelected,
    required this.questions,
    required this.index,
  });

  copyWith({
    List<QuestionEntity>? questions,
    int? index,
    int? isSelected,
  }) {
    return QuestionComplete(
      isSelected: isSelected ?? this.isSelected,
      questions: questions ?? this.questions,
      index: index ?? this.index,
    );
  }
}

class QuestionError extends QuestionsState {
  final String error;

  QuestionError(this.error);
}

part of 'questions_bloc.dart';

@immutable
sealed class QuestionsEvent {}

class QuestionsEventGet extends QuestionsEvent {
  final String userId;

  QuestionsEventGet(this.userId);
}

class QuestionEventSetSelected extends QuestionsEvent {
  final int index;

  QuestionEventSetSelected(this.index);
}

class QuestionEventCheckQuestion extends QuestionsEvent {
  final String questionId;
  final String userId;
  QuestionEventCheckQuestion(this.questionId, this.userId);
}

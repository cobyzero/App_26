import 'package:app_26/Features/Questions/Domain/Entities/question_entity.dart';

abstract class QuestionRepository {
  Future<List<QuestionEntity>> getQuestions(String userId);
  Future<void> checkQuestion(String questionId, String userId);
}

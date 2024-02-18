import 'package:app_26/Features/Questions/Application/Services/questions_service.dart';
import 'package:app_26/Features/Questions/Domain/Entities/question_entity.dart';
import 'package:app_26/Features/Questions/Domain/Repositories/questions_repository.dart';

class IQuestionRepository extends QuestionRepository {
  final QuestionService service;

  IQuestionRepository(this.service);

  @override
  Future<List<QuestionEntity>> getQuestions(String userId) async {
    final data = await service.getQuestions(userId);
    try {
      return data.docs.map((e) => QuestionEntity.fromJson(e.data())).toList();
    } catch (e) {
      throw "No se pudo mapear questions";
    }
  }

  @override
  Future<void> checkQuestion(String questionId, String userId) async {
    await service.checkQuestion(questionId, userId);
  }
}

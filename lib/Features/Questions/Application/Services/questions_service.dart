import 'package:app_26/Features/Auth/Domain/Entities/user_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class QuestionService {
  final firebase = FirebaseFirestore.instance;

  Future<QuerySnapshot<Map<String, dynamic>>> getQuestions(String userId) async {
    try {
      return await firebase.collection("Questions").where("userId", isEqualTo: userId).get();
    } catch (e) {
      throw Exception("No se pudo obtener las preguntas");
    }
  }

  Future<void> checkQuestion(String questionId, String userId) async {
    try {
      await firebase.collection("Questions").doc(questionId).update(
        {"isResolved": true},
      );
      final data = await firebase.collection("Users").doc(userId).get();
      final user = UserEntity.fromJson(data.data()!);

      await firebase.collection("Users").doc(userId).update({
        "keys": user.keys + 1,
      });
    } catch (e) {
      throw Exception("No se pudo obtener las preguntas");
    }
  }
}

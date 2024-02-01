import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final firebase = FirebaseFirestore.instance;

  Future<String> login(String key) async {
    try {
      final response = await firebase.collection("Users").where("key", isEqualTo: key).get();

      return response.docs.first.id;
    } catch (e) {
      throw Exception("No se encontro la key");
    }
  }
}

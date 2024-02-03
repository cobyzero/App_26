import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final firebase = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> login(String key) {
    try {
      return firebase.collection("Users").where("key", isEqualTo: key).snapshots();
    } catch (e) {
      throw Exception("No se encontro la key");
    }
  }
}

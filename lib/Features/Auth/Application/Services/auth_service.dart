import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final firebase = FirebaseFirestore.instance;

  Future<QuerySnapshot<Map<String, dynamic>>> login(String key) async {
    try {
      return await firebase
          .collection("Users")
          .where(
            "key",
            isEqualTo: key,
          )
          .get();
    } catch (e) {
      throw "No se encontro la key";
    }
  }
}

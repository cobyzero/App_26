import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  final firebase = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> getUser(String userId) {
    return firebase.collection("Users").where("id", isEqualTo: userId).snapshots();
  }
}

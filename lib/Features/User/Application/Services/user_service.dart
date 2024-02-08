import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  final firebase = FirebaseFirestore.instance;

  Stream<DocumentSnapshot<Map<String, dynamic>>> getUser(String userId) {
    return firebase.collection("Users").doc(userId).snapshots();
  }
}

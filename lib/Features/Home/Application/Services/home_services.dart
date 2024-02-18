import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeServices {
  final firebase = FirebaseFirestore.instance;
  Stream<QuerySnapshot<Map<String, dynamic>>> getMemorys(String userId) async* {
    try {
      yield* firebase
          .collection("Memorys")
          .where(
            "userId",
            isEqualTo: userId,
          )
          .snapshots();
    } catch (e) {
      throw "Error al obtener memorys";
    }
  }

  Future<void> unlockMemory(int keys, String memoryId) async {
    try {
      final id = FirebaseAuth.instance.currentUser!.uid;
      final user = await firebase.collection("Users").where("id", isEqualTo: id).get();

      await firebase.collection("Users").doc(user.docs.first.id).update({
        "keys": keys - 1,
      });

      await firebase.collection("Memorys").doc(memoryId).update({
        "isBlocked": false,
      });
    } catch (e) {
      throw "Error al desbloquear memoria";
    }
  }
}

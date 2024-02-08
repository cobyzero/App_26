import 'package:cloud_firestore/cloud_firestore.dart';

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

  Future<void> unlockMemory(String userId, int keys, String memoryId) async {
    try {
      await firebase.collection("Users").doc(userId).update({
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

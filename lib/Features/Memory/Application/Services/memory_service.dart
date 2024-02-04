import 'dart:io';

import 'package:app_26/Features/Memory/Domain/Entities/memory_create_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class MemoryService {
  final firebase = FirebaseFirestore.instance;
  final storage = FirebaseStorage.instance;

  Future<void> createMemory(MemoryCreateEntity entity, String pathImage) async {
    try {
      final user = await firebase
          .collection("Users")
          .where(
            "key",
            isEqualTo: entity.userId,
          )
          .get();

      entity = entity.copyWith(userId: user.docs.first.id);

      final storageRef = storage.ref().child("${entity.userId}/${entity.image}");

      File imageFile = File(pathImage);
      storageRef.putFile(imageFile).whenComplete(
        () async {
          final memory = await firebase.collection("/Memorys").add(entity.toJson());

          await firebase.collection("Memorys").doc(memory.id).update(
            {"id": memory.id},
          );
        },
      );
    } catch (e) {
      throw Exception("Error al subir memory");
    }
  }
}

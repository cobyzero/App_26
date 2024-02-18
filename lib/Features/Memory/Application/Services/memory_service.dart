import 'dart:io';

import 'package:app_26/Features/Auth/Domain/Entities/user_entity.dart';
import 'package:app_26/Features/Memory/Domain/Entities/memory_create_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class MemoryService {
  final firebase = FirebaseFirestore.instance;
  final storage = FirebaseStorage.instance;

  Future<void> createMemory(MemoryCreateEntity entity, String key) async {
    try {
      final id = FirebaseAuth.instance.currentUser!.uid;
      final userMain = await firebase
          .collection("Users")
          .where(
            "id",
            isEqualTo: id,
          )
          .get();

      final user = await firebase
          .collection("Users")
          .where(
            "key",
            isEqualTo: key,
          )
          .get();

      final userModel = UserEntity.fromJson(user.docs.first.data());

      final userModelMain = UserEntity.fromJson(userMain.docs.first.data());

      entity = entity.copyWith(userId: userModel.id);

      for (var i = 0; i < entity.image.length; i++) {
        final storageRef = storage.ref().child("${entity.userId}/${entity.image[i]}");

        File imageFile = File(entity.pathImage[i]);
        await storageRef.putFile(imageFile);
      }

      await firebase.collection("Users").doc(userMain.docs.first.id).update(
        {"keys": userModelMain.keys - 1},
      );

      final memory = await firebase.collection("Memorys").add(entity.toJson());

      await firebase.collection("Memorys").doc(memory.id).update(
        {"id": memory.id},
      );
    } catch (e) {
      throw "Error al crear recuerdo";
    }
  }

  Future<bool?> validateKey(String key) async {
    try {
      final user = await firebase
          .collection("Users")
          .where(
            "key",
            isEqualTo: key,
          )
          .get();

      if (user.docs.isNotEmpty) {
        return true;
      }
      return false;
    } catch (e) {
      throw "Error al validar key";
    }
  }
}

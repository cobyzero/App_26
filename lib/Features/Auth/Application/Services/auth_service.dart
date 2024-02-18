import 'package:app_26/Features/Auth/Domain/Entities/user_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final firebase = FirebaseFirestore.instance;

  Future<String> login(GoogleSignInAccount google) async {
    try {
      final googleAuth = await google.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final credentials = await FirebaseAuth.instance.signInWithCredential(credential);

      final user = await firebase.collection("Users").where("id", isEqualTo: credentials.user!.uid).get();

      if (user.docs.firstOrNull == null) {
        final nUser = UserEntity(
            name: credentials.user!.displayName!,
            keys: 5,
            id: credentials.user!.uid,
            key: credentials.user!.uid.substring(0, 5));

        await firebase.collection("Users").add(nUser.toJson());
      }
      return credentials.user!.uid;
    } catch (e) {
      throw "Error al iniciar sesión";
    }
  }
}

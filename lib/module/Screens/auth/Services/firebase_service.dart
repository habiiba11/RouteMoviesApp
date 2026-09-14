import 'package:firebase_auth/firebase_auth.dart';

 class FirebaseService {
  Future<UserCredential?> createAccount({
    required String name,
    required String password,
    required String email,
  }) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      credential.user?.updateProfile(displayName: name);
      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        throw 'The account already exists for that email.';
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }
}

Future<UserCredential?> login({
  required String password,
  required String email,
}) async {
  try {
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return credential;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      throw 'No user found for that email.';
    } else {
      throw 'Invalid Email OR Password';
    }
  }
}

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:google_sign_in/google_sign_in.dart';
//
// class FirebaseService {
//   Future<UserCredential?> createAccount({
//     required String name,
//     required String password,
//     required String email,
//   }) async {
//     try {
//       final credential = await FirebaseAuth.instance
//           .createUserWithEmailAndPassword(email: email, password: password);
//       credential.user?.updateProfile(displayName: name);
//       return credential;
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'weak-password') {
//         throw 'The password provided is too weak.';
//       } else if (e.code == 'email-already-in-use') {
//         throw 'The account already exists for that email.';
//       }
//     } catch (e) {
//       rethrow;
//     }
//     return null;
//   }
//
//   static final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
//
//   static Future <UserCredential> signInWithGoogle() async {
//     await _googleSignIn.initialize(
//       clientId: "126679348688-0bfstg4nas3lge5itb65jb9thpbc7m25.apps.googleusercontent.com",
//     );
//     final GoogleSignInAccount result = await _googleSignIn.authenticate();
//     final googleAuth = result.authentication;
//     final credentials = GoogleAuthProvider.credential(
//       idToken: googleAuth.idToken,
//     );
//     return await FirebaseAuth.instance.signInWithCredential(credentials);
//   }
//
//
//   Future<UserCredential?> login({
//     required String password,
//     required String email,
//   }) async {
//     try {
//       final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       return credential;
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'user-not-found') {
//         throw 'No user found for that email.';
//       } else {
//         throw 'Invalid Email OR Password';
//       }
//     }
//   }
//
// }
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseService {
  Future<UserCredential?> createAccount({
    required String name,
    required String password,
    required String email,
  }) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await credential.user?.updateDisplayName(name);

      return credential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        throw 'The account already exists for that email.';
      } else {
        throw e.message ?? 'Something went wrong';
      }
    }
  }

  static final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  static Future<UserCredential> signInWithGoogle() async {
    await _googleSignIn.initialize(
      clientId:
      "126679348688-0bfstg4nas3lge5itb65jb9thpbc7m25.apps.googleusercontent.com",
    );

    final GoogleSignInAccount result =
    await _googleSignIn.authenticate();

    final googleAuth = result.authentication;

    final credentials = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credentials);
  }

  Future<UserCredential?> login({
    required String password,
    required String email,
  }) async {
    try {
      final credential =
      await FirebaseAuth.instance.signInWithEmailAndPassword(
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

  // ==============================
  // UPDATE USER PROFILE
  // ==============================

  Future<void> updateUserProfile({
    required String name,
    String? photoUrl,
  }) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      throw 'No user is currently logged in.';
    }

    await user.updateDisplayName(name);

    if (photoUrl != null) {
      await user.updatePhotoURL(photoUrl);
    }

    await user.reload();
  }

  // ==============================
  // DELETE ACCOUNT
  // ==============================

  Future<void> deleteAccount() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      throw 'No user is currently logged in.';
    }

    await user.delete();
  }

  // ==============================
  // RESET PASSWORD
  // ==============================

  Future<void> resetPassword() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user?.email == null) {
      throw 'No email found for this account.';
    }

    await FirebaseAuth.instance.sendPasswordResetEmail(
      email: user!.email!,
    );
  }
}
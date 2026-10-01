import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  static bool _initialized = false;

  static Future<UserCredential?> signInWithGoogle() async {
    final google = GoogleSignIn.instance;

    try {
      if (!_initialized) {
        await google.initialize(
          serverClientId: 'YOUR_WEB_CLIENT_ID',
        );
        _initialized = true;
      }

      final account = await google.authenticate();

      print('Google Account: ${account.email}');
      print('ID Token: ${account.authentication.idToken}');

      final credential = GoogleAuthProvider.credential(
        idToken: account.authentication.idToken,
      );

      return await FirebaseAuth.instance.signInWithCredential(credential);
    } on GoogleSignInException catch (e) {
      print('Google Sign-In Exception: $e');
      rethrow;
    } on FirebaseAuthException catch (e) {
      print('Firebase Auth Exception: ${e.code}');
      print('Message: ${e.message}');
      rethrow;
    } catch (e) {
      print('Unknown Error: $e');
      rethrow;
    }
  }

  static Future<void> signOut() async {
    await GoogleSignIn.instance.signOut();
    await FirebaseAuth.instance.signOut();
  }
}
import 'package:firebase_auth/firebase_auth.dart';
import 'package:foodninga/core/errors/exceptions.dart';
import 'package:foodninga/core/errors/failures.dart';
import 'package:foodninga/features/auth/domain/entities/user_entity.dart';
import 'package:google_sign_in/google_sign_in.dart' as g_auth;

class FirebaseAuthServices {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Future<UserEntity> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return UserEntity(
        uid: credential.user!.uid,
        email: credential.user!.email!,
        name: credential.user?.displayName ?? "",
        photoUrl: credential.user?.photoURL ?? "",
        phone: credential.user?.phoneNumber ?? "",
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw AuthException(message: 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw AuthException(
          message: 'The account already exists for that email.',
        );
      }
      throw AuthException(message: e.message ?? 'An error occurred');
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  Future<UserEntity> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return UserEntity(
        uid: credential.user!.uid,
        email: credential.user!.email!,
        name: credential.user?.displayName ?? "",
        photoUrl: credential.user?.photoURL ?? "",
        phone: credential.user?.phoneNumber ?? "",
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw AuthException(message: 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw AuthException(
          message: 'The account already exists for that email.',
        );
      }
      throw AuthException(message: e.message ?? 'An error occurred');
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      throw AuthException(message: e.message ?? 'An error occurred');
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  Future<UserEntity> signInWithGoogle() async {
    try {
      final g_auth.GoogleSignIn googleSignIn = g_auth.GoogleSignIn(
        scopes: ['email'],
      );

      final g_auth.GoogleSignInAccount? googleUser = await googleSignIn
          .signIn();

      if (googleUser == null) {
        throw AuthException(message: 'Google sign in canceled');
      }

      final g_auth.GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: (googleAuth as dynamic).accessToken,
        idToken: (googleAuth as dynamic).idToken,
      );

      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(credential);

      return UserEntity(
        uid: userCredential.user!.uid,
        email: userCredential.user!.email ?? '',
        name: userCredential.user!.displayName ?? 'Google user',
        photoUrl: userCredential.user!.photoURL ?? '',
        phone: userCredential.user?.phoneNumber ?? "",
      );
    } on AuthException {
      rethrow;
    } catch (e) {
      throw ServerException(
        message: 'Error during sign in: ${e.toString()}',
      );
    }
  }

  Future<void> sendPasswordResetEmail({required String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw AuthException(
          message: ' There is no account associated with this email address .',
        );
      }
      throw AuthException(
        message:
            e.message ??
            ' An error occurred while sending the reset link : ${e.toString()}',
      );
    } catch (e) {
      throw ServerException(
        message: 'An unexpected error occurred: ${e.toString()}',
      );
    }
  }

  String? getCurrentUserUid() {
    return _firebaseAuth.currentUser?.uid;
  }

  Future<void> deleteAccount() async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user != null) {
        await user.delete();
      } else {
        throw AuthException(message: 'no user is currently logged in');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        throw AuthException(message: 'please relogin to delete the account .');
      }
      throw AuthException(
        message: e.message ?? 'an error occurred while deleting the account ',
      );
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}

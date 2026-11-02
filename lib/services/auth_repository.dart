import 'package:firebase_auth/firebase_auth.dart';
import 'package:mail_tracking_service/exceptions/auth_exception.dart';

class AuthRepository {
  Future<void> signUp({required String email, required String password, required String name}) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password
      );

      User? user = currentUser;

      if(user != null) {
        await user.updateDisplayName(name);
        await user.reload();
      }
    } on FirebaseAuthException catch (e) {
      throw AuthException(errorCode: e.code);
    }
    catch (e) {
      throw AuthException(errorCode: 'Не вдалося виконати операцію. Спробуйте ще раз');
    }
  }

  Future<void> signIn({required String email, required String password}) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
    } on FirebaseAuthException catch (e) {
      throw AuthException(errorCode: e.code);
    } catch (e) {
      throw AuthException(errorCode: 'Не вдалося виконати операцію. Спробуйте ще раз');
    }
  }

  Future<void> sendPasswordReset({required String email}) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
          email: email
      );
    } on FirebaseAuthException catch (e) {
      throw AuthException(errorCode: e.code);
    } catch (e) {
      throw AuthException(errorCode: 'Не вдалося виконати операцію. Спробуйте ще раз');
    }
  }

  User? get currentUser => FirebaseAuth.instance.currentUser;
  Stream<User?> get userChanges => FirebaseAuth.instance.userChanges();
  Stream<User?> get authStateChanges => FirebaseAuth.instance.authStateChanges();

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<void> updateName({required String name}) async {
    try {
      await currentUser?.updateDisplayName(name);
      await currentUser?.reload();
    } on FirebaseAuthException catch (e) {
      throw AuthException(errorCode: e.code);
    } catch (e) {
      throw AuthException(errorCode: 'Не вдалося виконати операцію. Спробуйте ще раз');
    }
  }

  Future<void> updatePhoto({String? photoUrl}) async {
    try {
      await currentUser?.updatePhotoURL(photoUrl ?? '');
      await currentUser?.reload();
    } on FirebaseAuthException catch (e) {
      throw AuthException(errorCode: e.code);
    } catch (e) {
      throw const AuthException(
        errorCode: 'Не вдалося виконати операцію. Спробуйте ще раз',
      );
    }
  }

  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    final user = currentUser;
    final email = user?.email;

    if (user == null || email == null) {
      throw const AuthException(errorCode: 'requires-recent-login');
    }

    try {
      final credential = EmailAuthProvider.credential(
        email: email,
        password: currentPassword,
      );
      await user.reauthenticateWithCredential(credential);
      await user.updatePassword(newPassword);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential' || e.code == 'wrong-password') {
        throw const AuthException(errorCode: 'wrong-current-password');
      }
      throw AuthException(errorCode: e.code);
    } catch (e) {
      throw const AuthException(
        errorCode: 'Не вдалося виконати операцію. Спробуйте ще раз',
      );
    }
  }
}
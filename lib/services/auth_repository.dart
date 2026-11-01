import 'package:firebase_auth/firebase_auth.dart';
import 'package:mail_tracking_service/exceptions/auth_exception.dart';

class AuthRepository {
  Future<void> signUp({required String email, required String password, required String name}) async {
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password
      );

      User? user = credential.user;

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
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
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
      final credential = await FirebaseAuth.instance.sendPasswordResetEmail(
          email: email
      );
    } on FirebaseAuthException catch (e) {
      throw AuthException(errorCode: e.code);
    } catch (e) {
      throw AuthException(errorCode: 'Не вдалося виконати операцію. Спробуйте ще раз');
    }
  }

  Future<void> changePassword({required String email, required String password}) async {

  }

  Future<void> updateName({required String email, required String password}) async {

  }

  Future<void> updatePhoto({required String email, required String password}) async {

  }

  Future<void> signOut() async {

  }

  // authStateChanges()
}
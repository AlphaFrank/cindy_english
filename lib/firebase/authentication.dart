import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationHelper {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  get user => _auth.currentUser;
  get uid => user.uid;

  Future signUp({required String email, required String password}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
      );
      return null;
    } on FirebaseException catch (e) {
      return e.message;
    }
  }

  String getUID() {
    return user.uid;
  }

  Future signIn({required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null;
    } on FirebaseException catch (e) {
      return e.message;
    }
  }

  Future signOut() async {
    await _auth.signOut();

    print('signout');
  }

}
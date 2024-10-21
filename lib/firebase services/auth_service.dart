import 'package:firebase_auth/firebase_auth.dart';

class authservice {
  final _auth = FirebaseAuth.instance;

  Future<User?> signUp(String emial, String password) async {
    try {
      UserCredential uc = await _auth.createUserWithEmailAndPassword(
          email: emial, password: password);
      return uc.user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<User?> signIn(String emial, String password) async {
    try {
      UserCredential uc = await _auth.signInWithEmailAndPassword(
          email: emial, password: password);
      return uc.user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  signOut() async {
    await _auth.signOut();
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class authUser {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  cadastrarUsuario(
      {required String nome,
      required String email,
      required String senha}) async {
    UserCredential userCredential = await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: senha);

    await userCredential.user!.updateDisplayName(nome);
    createUserDocument(userCredential, nome);
  }

  Future<String?> logarUsuario(
      {required String email, required String senha}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: senha);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<void> deslogar() async {
    return _firebaseAuth.signOut();
  }
}

Future<void> createUserDocument(
    UserCredential? userCredential, String nome) async {
  if (userCredential != null && userCredential.user != null) {
    await FirebaseFirestore.instance
        .collection('Users')
        .doc(userCredential.user!.email)
        .set({
      'email': userCredential.user!.email,
      'nome': nome,
    });
  }
}

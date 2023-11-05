import 'package:firebase_auth/firebase_auth.dart';

class authUser {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  cadastrarUsuario(
      {required String nome,
      required String email,
      required String telefone,
      required String cpf,
      required String senha}) async {
    UserCredential userCredential = await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: senha);

    await userCredential.user!.updateDisplayName(nome);
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
}

import 'package:firebase_auth/firebase_auth.dart';

class authUser {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  cadastrarUsuario(
      {required String nome,
      required String email,
      required String telefone,
      required String cpf,
      required String senha}) {
    _firebaseAuth.createUserWithEmailAndPassword(email: email, password: senha);
  }
}

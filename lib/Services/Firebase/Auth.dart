import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lackstage/Responsive/Web/DesktopHomePage.dart';
import 'package:lackstage/Services/Notification/notification_service.dart';
import 'package:lackstage/Utils.dart';

class authUser {
  final defaultimage =
      'https://cdn.icon-icons.com/icons2/2596/PNG/512/check_small_icon_155663.png';
  final CollectionReference usuarios =
      FirebaseFirestore.instance.collection('Users');
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  NotificationService notificationService = NotificationService();

  cadastrarUsuario(
      {required String nome,
      required String usuario,
      required String email,
      required String senha,
      required BuildContext context}) async {
    int checkedFields = 0;

    if (nome.isEmpty || usuario.isEmpty || email.isEmpty || senha.isEmpty) {
      showSnackBar(context, 'Preencha todos os campos');
    } else if (senha.length < 6) {
      showSnackBar(context, 'A senha precisa ter no minimo 6 digitos');
    } else {
      await usuarios
          .where('NomeUsuario', isEqualTo: usuario)
          .get()
          .then((snapshots) {
        if (snapshots.size != 0) {
          checkedFields++;
          // ignore: use_build_context_synchronously
          showSnackBar(context, 'O nome de usuário escolhido ja está em uso');
        }
      });

      await usuarios.where('email', isEqualTo: email).get().then((snapshots) {
        if (snapshots.size != 0) {
          checkedFields++;
          // ignore: use_build_context_synchronously
          showSnackBar(context, 'O e-mail informado já está em uso');
        }
      });
      if (checkedFields == 0) {
        String? token = await notificationService.getToken();
        UserCredential userCredential = await _firebaseAuth
            .createUserWithEmailAndPassword(email: email, password: senha);

        await userCredential.user!.updateDisplayName(usuario);
        await userCredential.user!.updatePhotoURL(defaultimage);
        createUserDocument(userCredential, nome, usuario, email, token!);
        // ignore: use_build_context_synchronously
        logarUsuario(email: email, senha: senha, context: context);
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
      }
    }
  }

  Future<String?> logarUsuario(
      {required String email,
      required String senha,
      required BuildContext context}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: senha);
      return null;
    } on FirebaseAuthException catch (e) {
      // ignore: use_build_context_synchronously
      showSnackBar(context, 'Email ou senha incorretos');
      return e.message;
    }
  }

  Future<void> deslogar() async {
    return _firebaseAuth.signOut();
  }

  Future<void> createUserDocument(UserCredential? userCredential, String nome,
      String usuario, String email, String token) async {
    if (userCredential != null && userCredential.user != null) {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(userCredential.user!.email)
          .set({
        'email': email,
        'nome': nome,
        'NomeUsuario': usuario,
        'Image': defaultimage,
        'Bio': '',
        'Token': token,
      });
    }
  }

  Future<void> updateBio(String nome, String bio, String email,
      BuildContext context, int numero) async {
    usuarios.doc(email).update({'Bio': bio});
    if (numero == 0) {
      Navigator.pop(context);
    } else {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const DesktopHomePage()));
    }
  }
}



/**  
 * 
 * 
 * 
 *   Future<Map<String, dynamic>> getUserData(String email) async {
    DocumentSnapshot snapshot =
        await FirebaseFirestore.instance.collection('Users').doc(email).get();

    if (snapshot.exists) {
      // Se o documento existir, retorne os dados como um mapa
      Map<String, dynamic> userData = snapshot.data() as Map<String, dynamic>;
      return userData;
    } else {
      return {};
    }
  }




 *     Map<String, dynamic> userData = await getUserData(email);
 *     String nomeAtual = userData['NomeUsuario'];
    if (nomeAtual != nome) {
      await usuarios
          .where('NomeUsuario', isEqualTo: nome)
          .get()
          .then((snapshots) {
        if (snapshots.size == 0) {
          usuarios.doc(email).update({'NomeUsuario': nome});
          FirebaseAuth.instance.currentUser!.updateDisplayName(nome);
        } else {
          showSnackBar(context, 'O nome de usuário informado ja está em uso');
        }
      }); */
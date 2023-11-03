import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lackstage/ui/login_field.dart';
import '../ui/social_button.dart';
import 'package:lackstage/ui/gradient_button.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController _nome = TextEditingController();
  RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  const Text('Registro',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 50)),
                  Image.asset(
                    'assets/images/Logo.png',
                    height: 150,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  const SizedBox(height: 15),
                  LoginField(controller: _nome, hintText: 'Nome'),
                  const SizedBox(height: 15),
                  const LoginField(hintText: 'Telefone'),
                  const SizedBox(height: 15),
                  const LoginField(hintText: 'CPF'),
                  const SizedBox(height: 15),
                  const LoginField(hintText: 'Email'),
                  const SizedBox(height: 15),
                  const LoginField(
                    hintText: 'Senha',
                    obscureText: true,
                  ),
                  const SizedBox(height: 20),
                  const SizedBox(height: 15),
                  GradientButton(
                    onPressed: () {
                      final Nome = _nome.text;
                      CreateUser(nome: Nome, context: context);
                    },
                    text: 'Cadastrar',
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SocialButton(
                        iconPath: 'assets/svgs/g_logo.svg',
                        onPressed: () {},
                      ),
                      const SizedBox(width: 20),
                      SocialButton(
                        iconPath: 'assets/svgs/f_logo.svg',
                        onPressed: () {},
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        )),
      ),
    ));
  }

  Future CreateUser(
      {required String nome, required BuildContext context}) async {
    final docUser = FirebaseFirestore.instance.collection('users').doc();
    final user = User(
      id: 12,
      nome: nome,
      email: 'maria@mmm.com',
      cpf: 05410067885,
      senha: 'petstttss',
    );
    final json = user.toJson();

    await docUser.set(json);
    Navigator.pop(context);
  }
}

class User {
  final int id;
  final String nome;
  final String email;
  final int cpf;
  final String senha;

  User(
      {required this.id,
      required this.nome,
      required this.email,
      required this.cpf,
      required this.senha});

  Map<String, dynamic> toJson() =>
      {'Id': id, 'Nome': nome, 'E-mail': email, 'CPF': cpf, 'Senha': senha};
}

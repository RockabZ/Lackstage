import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lackstage/ui/login_field.dart';
import '../ui/social_button.dart';
import 'package:lackstage/ui/gradient_button.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController _nome = TextEditingController();
  final TextEditingController _telefone = TextEditingController();
  final TextEditingController _cpf = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _senha = TextEditingController();

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
                  LoginField(controller: _nome, hintText: 'Nome Completo'),
                  const SizedBox(height: 15),
                  LoginField(controller: _telefone, hintText: 'Telefone'),
                  const SizedBox(height: 15),
                  LoginField(controller: _cpf, hintText: 'CPF'),
                  const SizedBox(height: 15),
                  LoginField(controller: _email, hintText: 'Email'),
                  const SizedBox(height: 15),
                  LoginField(
                    hintText: 'Senha',
                    obscureText: true,
                    controller: _senha,
                  ),
                  const SizedBox(height: 20),
                  const SizedBox(height: 15),
                  GradientButton(
                    onPressed: () {
                      final Nome = _nome.text;
                      final telefone = _telefone.text;
                      final cpf = _cpf.text;
                      final email = _email.text;
                      final senha = _senha.text;
                      CreateUser(
                          nome: Nome,
                          email: email,
                          telefone: telefone,
                          cpf: cpf,
                          senha: senha,
                          context: context);
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
      {required String nome,
      required String email,
      required String telefone,
      required String cpf,
      required String senha,
      required BuildContext context}) async {
    final docUser = FirebaseFirestore.instance.collection('users').doc();
    final user = User(
      id: docUser.id,
      nome: nome,
      telefone: telefone,
      email: email,
      cpf: cpf,
      senha: senha,
    );
    final json = user.toJson();

    await docUser.set(json);
    Navigator.pop(context);
  }
}

class User {
  final String id;
  final String nome;
  final String telefone;
  final String email;
  final String cpf;
  final String senha;

  User(
      {required this.id,
      required this.nome,
      required this.telefone,
      required this.email,
      required this.cpf,
      required this.senha});

  Map<String, dynamic> toJson() => {
        'Id': id,
        'Nome': nome,
        'Telefone': telefone,
        'E-mail': email,
        'CPF': cpf,
        'Senha': senha
      };
}

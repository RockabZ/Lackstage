import 'package:flutter/material.dart';
import 'package:lackstage/ui/login_field.dart';
import '../ui/social_button.dart';
import 'package:lackstage/ui/gradient_button.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

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
                  const Text('Lackstage',
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
                  const LoginField(hintText: 'Nome'),
                  const SizedBox(height: 15),
                  const LoginField(hintText: 'Sobrenome'),
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
                      Navigator.pop;
                    },
                    text: 'Cadastrar',
                  ),
                ],
              ),
            ),
          ],
        )),
      ),
    ));
  }
}

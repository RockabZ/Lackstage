import 'package:flutter/material.dart';
import 'package:lackstage/Services/Firebase/Auth.dart';
import 'package:lackstage/ui/login_field.dart';
import '../ui/social_button.dart';
import 'package:lackstage/ui/gradient_button.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _nome = TextEditingController();

  final TextEditingController _email = TextEditingController();

  final TextEditingController _senha = TextEditingController();

  authUser _authUser = authUser();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Lackstage',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50)),
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
                  final nome = _nome.text;
                  final email = _email.text;
                  final senha = _senha.text;
                  _authUser.cadastrarUsuario(
                      nome: nome, email: email, senha: senha);
                  Navigator.pop(context);
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
        ],
      )),
    );
  }
}

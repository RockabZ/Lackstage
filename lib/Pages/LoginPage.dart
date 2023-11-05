import 'package:flutter/material.dart';
import 'package:lackstage/Services/Firebase/Auth.dart';
import 'package:lackstage/ui/gradient_button.dart';
import 'package:lackstage/ui/login_field.dart';
import '../ui/social_button.dart';
import 'HomePage.dart';
import 'RegisterPage.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _email = TextEditingController();

  final TextEditingController _senha = TextEditingController();

  authUser _authUser = authUser();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Login',
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
                LoginField(controller: _email, hintText: 'Email'),
                const SizedBox(height: 15),
                LoginField(
                  controller: _senha,
                  hintText: 'Senha',
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                GradientButton(
                  onPressed: () {
                    final email = _email.text;
                    final senha = _senha.text;
                    _authUser
                        .logarUsuario(email: email, senha: senha)
                        .then((String? erro) {
                      if (erro != null) {
                        print(erro);
                      }
                    });
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  },
                  text: 'Entrar',
                ),
                const SizedBox(height: 15),
                GradientButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterPage()));
                    },
                    text: 'Registrar-se'),
                const SizedBox(height: 20),
                const Text(
                  'ou',
                  style: TextStyle(
                    fontSize: 17,
                  ),
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
        ),
      ),
    );
  }
}

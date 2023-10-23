import 'package:flutter/material.dart';
import 'package:lackstage/ui/gradient_button.dart';
import 'package:lackstage/ui/login_field.dart';
import '../ui/social_button.dart';
import 'HomePage.dart';
import 'RegisterPage.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 20),
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
              const LoginField(hintText: 'Email'),
              const SizedBox(height: 15),
              const LoginField(hintText: 'Senha'),
              const SizedBox(height: 20),
              GradientButton(
                onPressed: () {
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
              SocialButton(
                iconPath: 'assets/svgs/g_logo.svg',
                label: 'Fazer login com o Google',
                onPressed: () {},
              ),
              const SizedBox(height: 20),
              SocialButton(
                iconPath: 'assets/svgs/f_logo.svg',
                label: 'Fazer login com o Facebook',
                horizontalPadding: 80,
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

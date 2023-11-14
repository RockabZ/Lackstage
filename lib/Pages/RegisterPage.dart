import 'package:flutter/material.dart';
import 'package:lackstage/Services/Firebase/Auth.dart';
import 'package:lackstage/ui/login_field.dart';
import '../ui/social_button.dart';
import 'package:lackstage/ui/gradient_button.dart';

class RegisterPage extends StatefulWidget {
  final double tamanho;
  const RegisterPage({super.key, required this.tamanho});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _nome = TextEditingController();

  final TextEditingController _email = TextEditingController();

  final TextEditingController _senha = TextEditingController();

  final _usuario = TextEditingController();

  final authUser _authUser = authUser();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 60),
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
                LoginField(
                    controller: _nome,
                    hintText: 'Nome Completo',
                    width: widget.tamanho),
                const SizedBox(height: 15),
                LoginField(
                  controller: _usuario,
                  hintText: 'Nome de Usuário',
                  width: widget.tamanho,
                ),
                const SizedBox(height: 15),
                LoginField(
                    controller: _email,
                    hintText: 'Email',
                    width: widget.tamanho),
                const SizedBox(height: 15),
                LoginField(
                    hintText: 'Senha',
                    obscureText: true,
                    controller: _senha,
                    width: widget.tamanho),
                const SizedBox(height: 20),
                const SizedBox(height: 15),
                GradientButton(
                  horizontalSize: widget.tamanho,
                  onPressed: () {
                    final nome = _nome.text;
                    final email = _email.text;
                    final senha = _senha.text;
                    final usuario = _usuario.text;
                    _authUser.cadastrarUsuario(
                        nome: nome,
                        email: email,
                        senha: senha,
                        usuario: usuario,
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
          ],
        )),
      ),
    );
  }
}

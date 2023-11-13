import 'package:flutter/material.dart';
import 'package:lackstage/Pages/LoginPage.dart';

class ResponsiveLogin extends StatelessWidget {
  const ResponsiveLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 500) {
          return LoginPage(tamanho: 300);
        } else {
          return LoginPage(tamanho: 400);
        }
      },
    );
  }
}

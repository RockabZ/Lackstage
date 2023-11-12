import 'package:flutter/material.dart';
import 'package:lackstage/Pallete.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Pallete.backgroundColor,
            centerTitle: true,
            title: const Text('Editar Perfil')),
        body: Container());
  }
}

import 'package:flutter/material.dart';
import 'package:lackstage/Pallete.dart';
import 'package:lackstage/Services/Firebase/Auth.dart';

var myAppBar = AppBar(
  centerTitle: true,
  title: const Text('Tela inicial'),
);

var myDrawer = Drawer(
  child: Column(children: [
    DrawerHeader(
        child: Image.asset(
      'assets/images/Logo.png',
      height: 75,
    )),
    ListTile(
      leading: const Icon(Icons.home),
      title: const Text('Pagina Inicial'),
      onTap: () {},
    ),
    ListTile(
      leading: const Icon(Icons.account_box_outlined),
      title: const Text('Perfil'),
      onTap: () {},
    ),
    Expanded(
      child: Align(
        alignment: FractionalOffset.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: const Icon(Icons.logout),
            iconColor: Pallete.redColor,
            title: const Text('Deslogar',
                style: TextStyle(color: Pallete.redColor)),
            onTap: () {
              authUser().deslogar();
            },
          ),
        ),
      ),
    )
  ]),
);

import 'package:flutter/material.dart';
import 'package:lackstage/Constants.dart';
import 'package:lackstage/Pallete.dart';
import 'package:lackstage/Services/Firebase/Auth.dart';

class DesktopHomePage extends StatefulWidget {
  const DesktopHomePage({super.key});

  @override
  State<DesktopHomePage> createState() => _DesktopHomePageState();
}

class _DesktopHomePageState extends State<DesktopHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar,
      body: Row(children: [
        //open drawer
        Drawer(
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
        ),

        //rest of the body
      ]),
    );
  }
}

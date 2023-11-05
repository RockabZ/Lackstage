import 'package:flutter/material.dart';
import 'package:lackstage/Services/Firebase/Auth.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tela inicial'),
      ),
      drawer: Drawer(
        child: ListView(children: [
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Deslogar'),
            onTap: () {
              authUser().deslogar();
            },
          )
        ]),
      ),
      body: const Column(
        children: [
          Placeholder(),
        ],
      ),
    );
  }
}

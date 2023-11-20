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
  int _page = 0;
  void onPageChange(int index) {
    setState(() {
      _page = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar,
      body: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        //open drawer
        Drawer(
          width: 250,
          elevation: 0,
          backgroundColor: Pallete.backgroundColor,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            DrawerHeader(
                child: Image.asset(
              'assets/images/Logo.png',
              height: 75,
            )),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Pagina Inicial'),
              onTap: () {
                onPageChange(0);
              },
            ),
            ListTile(
              leading: const Icon(Icons.search),
              title: const Text('Explorar'),
              onTap: () {
                onPageChange(1);
              },
            ),
            ListTile(
              leading: const Icon(Icons.account_box_outlined),
              title: const Text('Perfil'),
              onTap: () {
                onPageChange(2);
              },
            ),
            ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text('Notificações'),
              onTap: () {
                onPageChange(3);
              },
            ),
            ListTile(
              leading: const Icon(Icons.message),
              title: const Text('Bate Papo'),
              onTap: () {
                onPageChange(4);
              },
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
            ),
          ]),
        ),
        Container(
          height: double.infinity,
          width: 0.5, // Largura da linha vertical
          color: Pallete.borderColor, // Cor da linha vertical
          margin: const EdgeInsets.symmetric(vertical: 8.0), // Margem vertical
        ),
        //rest of the body
        SizedBox(
            width: 600,
            height: double.infinity,
            child:
                IndexedStack(index: _page, children: AssetsConstants.pagesweb)),
        Container(
          height: double.infinity,
          width: 0.5, // Largura da linha vertical
          color: Pallete.borderColor, // Cor da linha vertical
          margin: const EdgeInsets.symmetric(vertical: 8.0), // Margem vertical
        ),
      ]),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lackstage/Constants.dart';
import 'package:lackstage/Responsive/Mobile/AddPost.dart';
import 'package:lackstage/Responsive/Mobile/user_profile.dart';
import 'package:lackstage/Pallete.dart';
import 'package:lackstage/Services/Firebase/Auth.dart';

class MobileHomePage extends StatefulWidget {
  const MobileHomePage({super.key});

  @override
  State<MobileHomePage> createState() => _HomePageState();
}

class _HomePageState extends State<MobileHomePage> {
  int _page = 0;

  void onPageChange(int index) {
    setState(() {
      _page = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: _page == 0 ? myAppBar : null,
      drawer: Drawer(
        child: Column(children: [
          DrawerHeader(
              child: Image.asset(
            'assets/images/Logo.png',
            height: 75,
          )),
          ListTile(
            leading: const Icon(Icons.account_box_outlined),
            title: const Text('Perfil'),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserProfile(
                      nome: user!.displayName.toString(),
                      image: user.photoURL.toString(),
                    ),
                  ));
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
          )
        ]),
      ),
      body: IndexedStack(
          index: _page, children: AssetsConstants.bottomTabBarPages),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddPostPage(),
              ));
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: CupertinoTabBar(
          currentIndex: _page,
          onTap: onPageChange,
          backgroundColor: Pallete.backgroundColor,
          items: [
            BottomNavigationBarItem(
                icon: Icon(_page == 0 ? Icons.home : Icons.home_outlined)),
            const BottomNavigationBarItem(icon: Icon(Icons.search)),
            BottomNavigationBarItem(
                icon: Icon(_page == 2
                    ? Icons.notifications
                    : Icons.notifications_outlined)),
            BottomNavigationBarItem(
                icon:
                    Icon(_page == 3 ? Icons.message : Icons.message_outlined)),
          ]),
    );
  }
}

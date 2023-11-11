import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lackstage/Constants.dart';
import 'package:lackstage/Pages/Posts/AddPost.dart';
import 'package:lackstage/Pallete.dart';

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
    return Scaffold(
      appBar: myAppBar,
      drawer: myDrawer,
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
        child: Icon(Icons.add),
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

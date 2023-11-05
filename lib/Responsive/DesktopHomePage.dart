import 'package:flutter/material.dart';
import 'package:lackstage/Constants.dart';

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
        myDrawer,

        //rest of the body
      ]),
    );
  }
}

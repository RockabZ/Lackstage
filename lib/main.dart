import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:lackstage/Responsive/Web/DesktopHomePage.dart';
import 'package:lackstage/Responsive/Mobile/MobileHomePage.dart';
import 'package:lackstage/Responsive/responsive_layout.dart';
import 'package:lackstage/Responsive/responsive_login.dart';
import 'Pallete.dart';
import 'firebase_options.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  initpushnotifications();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lackstage',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Pallete.backgroundColor,
      ),
      home: RoteadorTela(),
    );
  }
}

class RoteadorTela extends StatelessWidget {
  const RoteadorTela({super.key});

  @override
  Widget build(BuildContext context) {
    requestPermission();
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.userChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const ResponsiveLayout(
            desktopScaffold: DesktopHomePage(),
            mobileScaffold: MobileHomePage(),
          );
        } else {
          return const ResponsiveLogin();
        }
      },
    );
  }

  void requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("aceitou");
    } else {
      print('nao aceitou');
    }
  }
}

Future initpushnotifications() async {
  FirebaseMessaging.instance.getInitialMessage();

  FirebaseMessaging.onMessageOpenedApp.listen((event) {});
}

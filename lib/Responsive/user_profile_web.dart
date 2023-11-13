import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lackstage/Pages/user_profile.dart';

class UserProfileWeb extends StatelessWidget {
  const UserProfileWeb({super.key});

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return UserProfile(
        nome: user!.displayName.toString(), image: user.photoURL.toString());
  }
}

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lackstage/Utils.dart';

class PostController {
  User? user = FirebaseAuth.instance.currentUser;
  void SharePost({
    required List<File> images,
    required String text,
    required BuildContext context,
  }) {
    if (text.isEmpty) {
      showSnackBar(context, 'Digite algo');
      return;
    }
    if (images.isNotEmpty) {
      _shareImagePost(images: images, text: text, context: context);
    } else {
      _shareTextPost(text: text, context: context);
    }
  }

  void _shareImagePost({
    required List<File> images,
    required String text,
    required BuildContext context,
  }) async {
    await FirebaseFirestore.instance.collection('Posts').doc().set({
      'Autor': user!.displayName,
      'Text': text,
      'Imagem': images,
      'Curtidas': 0,
      'Reposts': 0,
      'Comentarios': 0,
      'TimeStamp': Timestamp.now(),
    });
  }

  Future<void> _shareTextPost({
    required String text,
    required BuildContext context,
  }) async {
    await FirebaseFirestore.instance.collection('Posts').doc().set({
      'Autor': user!.displayName,
      'Text': text,
      'Curtidas': [],
      'Reposts': 0,
      'Comentarios': 0,
      'TimeStamp': Timestamp.now(),
    });
    // ignore: use_build_context_synchronously
    Navigator.pop(context);
  }
}

Future<void> createTextPost(UserCredential? userCredential, String text) async {
  if (userCredential != null && userCredential.user != null) {
    await FirebaseFirestore.instance.collection('Posts').doc().set({
      'Autor': userCredential.user!.displayName,
      'Text': text,
      'Curtidas': 0,
      'Reposts': 0,
      'Comentarios': 0,
    });
  }
}

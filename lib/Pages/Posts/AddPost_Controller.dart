import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lackstage/Utils.dart';

class PostController {
  User? user = FirebaseAuth.instance.currentUser;
  void SharePost({
    required String repliedto,
    required List<File> images,
    required String text,
    required BuildContext context,
    required String autorreply,
  }) {
    if (repliedto.isNotEmpty) {
      _incrementComent(id: repliedto);
    }
    if (text.isEmpty) {
      showSnackBar(context, 'Digite algo');
      return;
    }
    if (images.isNotEmpty) {
      _shareImagePost(images: images, text: text, context: context);
    } else {
      _shareTextPost(
          text: text,
          context: context,
          repliedto: repliedto,
          autor: autorreply);
    }
  }

  void _incrementComent({required String id}) async {
    await FirebaseFirestore.instance
        .collection('Posts')
        .doc(id)
        .update({'Comentarios': FieldValue.increment(1)});
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
    required String repliedto,
    required String autor,
  }) async {
    await FirebaseFirestore.instance.collection('Posts').doc().set({
      'Autor': user!.displayName,
      'Text': text,
      'Curtidas': [],
      'Reposts': 0,
      'Comentarios': 0,
      'TimeStamp': Timestamp.now(),
      'RepliedTo': repliedto,
      'AutorReply': autor,
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

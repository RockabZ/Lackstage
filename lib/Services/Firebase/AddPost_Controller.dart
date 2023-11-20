import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lackstage/Services/Notification/notification_service.dart';
import 'package:lackstage/Utils.dart';

class PostController {
  NotificationService notificationService = NotificationService();
  User? user = FirebaseAuth.instance.currentUser;
  void SharePost({
    required String repliedto,
    required List<File> images,
    required String text,
    required BuildContext context,
    required String autorreply,
    required int numero,
  }) {
    if (text.isEmpty) {
      showSnackBar(context, 'Digite algo');
      return;
    } else {
      if (repliedto.isNotEmpty) {
        _incrementComent(id: repliedto);
        notificationService.createNotification(autorreply, repliedto, 'comment',
            '${user!.displayName} comentou seu Post');
      }
      if (images.isNotEmpty) {
        _shareImagePost(images: images, text: text, context: context);
      } else {
        _shareTextPost(
            text: text,
            context: context,
            repliedto: repliedto,
            autor: autorreply,
            numero: numero);
      }
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

  Future<void> _shareTextPost(
      {required String text,
      required BuildContext context,
      required String repliedto,
      required String autor,
      required int numero}) async {
    await FirebaseFirestore.instance.collection('Posts').doc().set({
      'Autor': user!.displayName,
      'Text': text,
      'Curtidas': [],
      'Reposts': 0,
      'Comentarios': 0,
      'TimeStamp': Timestamp.now(),
      'RepliedTo': repliedto,
      'AutorReply': autor,
      'AImage': user!.photoURL,
    });
    // ignore: use_build_context_synchronously
    if (numero == 0) {
      Navigator.pop(context);
    }
  }
}

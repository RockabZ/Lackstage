import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lackstage/Utils.dart';

class PostController {
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
  }) {}

  void _shareTextPost({
    required String text,
    required BuildContext context,
  }) {}
}

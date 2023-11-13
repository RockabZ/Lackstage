import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lackstage/Pages/Posts/AddPost_Controller.dart';
import 'package:lackstage/Pallete.dart';
import 'package:lackstage/Utils.dart';

class AddPostPage extends StatefulWidget {
  const AddPostPage({super.key});

  @override
  State<AddPostPage> createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
  User? user = FirebaseAuth.instance.currentUser;

  List<File> images = [];
  PostController postar = PostController();
  final TextEditingController _text = TextEditingController();

  void onPickImages() async {
    images = await pickImages();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Pallete.backgroundColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.close, size: 30),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0).copyWith(left: 15, right: 15),
            child: GestureDetector(
                onTap: onPickImages,
                child: const Icon(Icons.add_photo_alternate_outlined)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0).copyWith(left: 15, right: 15),
            child: const Icon(Icons.add_reaction_outlined),
          )
        ],
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(user!.photoURL.toString()),
                    radius: 30,
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: TextField(
                      controller: _text,
                      style: const TextStyle(fontSize: 22),
                      decoration: const InputDecoration(
                          hintText: "O que está acontecendo?",
                          hintStyle: TextStyle(
                            color: Pallete.greyColor,
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                          ),
                          border: InputBorder.none),
                      maxLines: null,
                    ),
                  )
                ],
              ),
            ),
            if (images.isNotEmpty)
              CarouselSlider(
                items: images.map(
                  (file) {
                    return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(horizontal: 5),
                        child: Image.file(file));
                  },
                ).toList(),
                options: CarouselOptions(
                  height: 400,
                  enableInfiniteScroll: false,
                ),
              )
          ],
        ),
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          postar.SharePost(
              images: images,
              text: _text.text,
              context: context,
              repliedto: '',
              autorreply: '',
              numero: 0);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lackstage/Constants.dart';
import 'package:lackstage/Pallete.dart';

class AddPostPage extends StatefulWidget {
  const AddPostPage({super.key});

  @override
  State<AddPostPage> createState() => _AddPostPageState();
}

class _AddPostPageState extends State<AddPostPage> {
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
      ),
      body: const SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(
                      'https://cdn-icons-png.flaticon.com/512/1816/1816466.png'),
                  radius: 30,
                ),
                SizedBox(width: 15),
                Expanded(
                  child: TextField(
                    style: TextStyle(fontSize: 22),
                    decoration: InputDecoration(
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
            )
          ],
        ),
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0).copyWith(left: 15, right: 15),
            child: const Icon(Icons.add_photo_alternate_outlined),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0).copyWith(left: 15, right: 15),
            child: const Icon(Icons.add_reaction_outlined),
          )
        ],
      ),
    );
  }
}

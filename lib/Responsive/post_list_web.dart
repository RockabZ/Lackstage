import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lackstage/Pages/Posts/AddPost_Controller.dart';
import 'package:lackstage/Pallete.dart';
import 'package:lackstage/ui/PostCard.dart';
import 'package:lackstage/Services/Firebase/GetPosts.dart';

class PostListWeb extends StatelessWidget {
  const PostListWeb({super.key});

  @override
  Widget build(BuildContext context) {
    final GetPosts database = GetPosts();
    final _text = TextEditingController();
    User? user = FirebaseAuth.instance.currentUser;
    PostController postar = PostController();

    return Column(
      children: [
        Container(
          decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Pallete.borderColor))),
          height: 130,
          child: Padding(
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
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: ElevatedButton(
                      onPressed: () {
                        postar.SharePost(
                            images: [],
                            text: _text.text,
                            context: context,
                            repliedto: '',
                            autorreply: '',
                            numero: 1);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              20.0), // Raio da borda para torná-la arredondada
                        ),
                      ),
                      child: const Text('Postar')),
                )
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        StreamBuilder(
          stream: database.getPostsStream(),
          builder: (context, snapshot) {
            //show loading circle
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            //get all posts
            final posts = snapshot.data!.docs;
            //no data
            if (snapshot.data == null || posts.isEmpty) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(25),
                  child: Text('Nenhum Post no momento... Poste algo'),
                ),
              );
            }

            // return as a list
            return Expanded(
              child: ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  // get individual post
                  final post = posts[index];

                  // get data from each post
                  String id = post.id;
                  String text = post['Text'];
                  String user = post['Autor'];
                  List<dynamic> curtidas = post['Curtidas'];
                  int comentarios = post['Comentarios'];
                  int reposts = post['Reposts'];
                  Timestamp timestamp = post['TimeStamp'];
                  String repliedto = post['RepliedTo'];
                  String autorreply = post['AutorReply'];
                  String aimage = post['AImage'];
                  // return as a list tile

                  return postCard(
                      id,
                      user,
                      text,
                      curtidas,
                      reposts,
                      comentarios,
                      timestamp,
                      context,
                      repliedto,
                      autorreply,
                      aimage);
                },
              ),
            );
          },
        ),
      ],
    );
  }
}

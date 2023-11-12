import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lackstage/ui/PostCard.dart';
import 'package:lackstage/Services/Firebase/GetPosts.dart';

class PostList extends StatelessWidget {
  const PostList({super.key});

  @override
  Widget build(BuildContext context) {
    final GetPosts database = GetPosts();

    return Column(
      children: [
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

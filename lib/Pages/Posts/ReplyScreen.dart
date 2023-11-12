import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lackstage/Pages/Posts/AddPost_Controller.dart';
import 'package:lackstage/Services/Firebase/GetPosts.dart';
import 'package:lackstage/ui/PostCard.dart';

class ReplyScreen extends StatelessWidget {
  final String id;
  final String nome;
  final String text;
  final List<dynamic> curtidas;
  final int reposts;
  final int comentarios;
  final Timestamp timestamp;
  final String repliedto;
  final String autorReply;
  final String aimage;
  const ReplyScreen(
      {super.key,
      required this.comentarios,
      required this.curtidas,
      required this.id,
      required this.nome,
      required this.reposts,
      required this.text,
      required this.timestamp,
      required this.repliedto,
      required this.autorReply,
      required this.aimage});

  @override
  Widget build(BuildContext context) {
    final GetPosts database = GetPosts();
    PostController postar = PostController();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Post'),
      ),
      body: Column(
        children: [
          postCard(id, nome, text, curtidas, reposts, comentarios, timestamp,
              context, repliedto, autorReply, aimage),
          StreamBuilder(
            stream: database.getRepliesPostsStream(id),
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
                    child: Text('Nenhum comentário no momento... Comente algo'),
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
                    String idr = post.id;
                    String textr = post['Text'];
                    String userr = post['Autor'];
                    String repliedtor = post['RepliedTo'];
                    List<dynamic> curtidasr = post['Curtidas'];
                    int comentariosr = post['Comentarios'];
                    int repostsr = post['Reposts'];
                    Timestamp timestampr = post['TimeStamp'];
                    String autorReply = post['AutorReply'];
                    String aimage = post['AImage'];

                    // return as a list tile
                    return postCard(
                        idr,
                        userr,
                        textr,
                        curtidasr,
                        repostsr,
                        comentariosr,
                        timestampr,
                        context,
                        repliedtor,
                        autorReply,
                        aimage);
                  },
                ),
              );
            },
          )
        ],
      ),
      bottomNavigationBar: TextField(
          onSubmitted: (value) {
            postar.SharePost(
                repliedto: id,
                images: [],
                text: value,
                context: context,
                autorreply: nome);
          },
          decoration: const InputDecoration(hintText: 'Poste sua reposta')),
    );
  }
}

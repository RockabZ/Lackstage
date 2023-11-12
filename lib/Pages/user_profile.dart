import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lackstage/Pages/edit_profile.dart';
import 'package:lackstage/Pallete.dart';
import 'package:lackstage/Services/Firebase/GetPosts.dart';
import 'package:lackstage/ui/PostCard.dart';

class UserProfile extends StatefulWidget {
  final String nome;
  final String image;
  const UserProfile({super.key, required this.nome, required this.image});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    final GetPosts database = GetPosts();
    User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Pallete.backgroundColor,
        centerTitle: true,
        title: const Text('Perfil'),
        actions: [
          user!.displayName == widget.nome
              ? Padding(
                  padding:
                      const EdgeInsets.all(8.0).copyWith(left: 15, right: 15),
                  child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditProfile(),
                            ));
                      },
                      child: const Icon(Icons.create_outlined)),
                )
              : Padding(
                  padding:
                      const EdgeInsets.all(8.0).copyWith(left: 15, right: 15),
                  child: GestureDetector(
                      onTap: () {}, child: const Icon(Icons.message)),
                ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              CircleAvatar(
                backgroundImage: NetworkImage(widget.image),
                radius: 45,
              ),
              const SizedBox(
                height: 10,
              ),
              DefaultTextStyle(
                style: const TextStyle(
                    color: Pallete.whiteColor,
                    fontSize: 35,
                    fontWeight: FontWeight.bold),
                child: Text(widget.nome),
              ),
              FutureBuilder(
                future: database.getBioByPerfil(user.email.toString()),
                builder: (context, snapshot) {
                  String bio = snapshot.data.toString();
                  return DefaultTextStyle(
                      style: const TextStyle(
                          color: Pallete.greyColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                      child: Text(bio));
                },
              ),
              const SizedBox(height: 20),
              const Text(
                'Posts',
                style: TextStyle(
                    color: Pallete.whiteColor,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              const Divider(
                color: Pallete.borderColor,
              ),
              StreamBuilder(
                stream: database.getPostsUser(widget.nome),
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
                        child: Text('Este usuario ainda não tem nenhum post'),
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
          ),
        ),
      ),
    );
  }
}

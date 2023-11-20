import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lackstage/Responsive/Mobile/chat_page.dart';
import 'package:lackstage/Responsive/Mobile/edit_profile.dart';
import 'package:lackstage/Pallete.dart';
import 'package:lackstage/Responsive/Web/edit_profile_web.dart';
import 'package:lackstage/Services/Chat/chat_service.dart';
import 'package:lackstage/Services/Firebase/GetPosts.dart';
import 'package:lackstage/ui/PostCard.dart';

class UserProfile extends StatefulWidget {
  final String nome;
  final String image;
  final String bio;
  final int numero;
  const UserProfile(
      {super.key,
      required this.nome,
      required this.image,
      this.bio = '',
      this.numero = 0});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    final GetPosts database = GetPosts();
    User? user = FirebaseAuth.instance.currentUser;
    final ChatService _chatService = ChatService();

    return Scaffold(
      appBar: widget.numero == 0
          ? AppBar(
              backgroundColor: Pallete.backgroundColor,
              centerTitle: true,
              title: const Text('Perfil'),
              actions: [
                user!.displayName == widget.nome
                    ? Padding(
                        padding: const EdgeInsets.all(8.0)
                            .copyWith(left: 15, right: 15),
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
                        padding: const EdgeInsets.all(8.0)
                            .copyWith(left: 15, right: 15),
                        child: GestureDetector(
                            onTap: () {
                              _chatService.createChatRoom(
                                  user.displayName.toString(), widget.nome);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ChatPage(receiverUserID: widget.nome),
                                  ));
                            },
                            child: const Icon(Icons.message)),
                      ),
              ],
            )
          : null,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              widget.numero == 0
                  ? const SizedBox(
                      width: 0,
                    )
                  : user!.displayName == widget.nome
                      ? Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0)
                                .copyWith(left: 15, right: 15),
                            child: GestureDetector(
                                onTap: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => EditProfileWeb(),
                                      ));
                                },
                                child: const Icon(Icons.create_outlined)),
                          ),
                        )
                      : Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0)
                                .copyWith(left: 15, right: 15),
                            child: GestureDetector(
                                onTap: () {
                                  _chatService.createChatRoom(
                                      user.displayName.toString(), widget.nome);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ChatPage(
                                            receiverUserID: widget.nome),
                                      ));
                                },
                                child: const Icon(Icons.message)),
                          ),
                        ),
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
              (widget.bio.isEmpty)
                  ? FutureBuilder(
                      future: database.getBioByPerfil(user!.email.toString()),
                      builder: (context, snapshot) {
                        String bio = snapshot.data.toString();
                        return DefaultTextStyle(
                            style: const TextStyle(
                                color: Pallete.greyColor,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                            child: Text(bio));
                      },
                    )
                  : DefaultTextStyle(
                      style: const TextStyle(
                          color: Pallete.greyColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                      child: Text(widget.bio)),
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
                            aimage,
                            0);
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

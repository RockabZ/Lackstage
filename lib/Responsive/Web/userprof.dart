import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lackstage/Constants.dart';
import 'package:lackstage/Pallete.dart';
import 'package:lackstage/Responsive/Mobile/chat_page.dart';
import 'package:lackstage/Responsive/Mobile/edit_profile.dart';
import 'package:lackstage/Services/Chat/chat_service.dart';
import 'package:lackstage/Services/Firebase/Auth.dart';
import 'package:lackstage/Services/Firebase/GetPosts.dart';
import 'package:lackstage/ui/PostCard.dart';

class UserClickedProfile extends StatefulWidget {
  final String nome;
  final String image;
  final String bio;
  final int numero;
  const UserClickedProfile(
      {super.key,
      required this.nome,
      required this.image,
      required this.bio,
      required this.numero});

  @override
  State<UserClickedProfile> createState() => _DesktopHomePageState();
}

class _DesktopHomePageState extends State<UserClickedProfile> {
  int _page = 10;
  void onPageChange(int index) {
    setState(() {
      _page = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final GetPosts database = GetPosts();
    User? user = FirebaseAuth.instance.currentUser;
    final ChatService _chatService = ChatService();
    return Scaffold(
      appBar: myAppBar,
      body: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        //open drawer
        Drawer(
          width: 250,
          elevation: 0,
          backgroundColor: Pallete.backgroundColor,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            DrawerHeader(
                child: Image.asset(
              'assets/images/Logo.png',
              height: 75,
            )),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Pagina Inicial'),
              onTap: () {
                onPageChange(0);
              },
            ),
            ListTile(
              leading: const Icon(Icons.search),
              title: const Text('Explorar'),
              onTap: () {
                onPageChange(1);
              },
            ),
            ListTile(
              leading: const Icon(Icons.account_box_outlined),
              title: const Text('Perfil'),
              onTap: () {
                onPageChange(2);
              },
            ),
            ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text('Notificações'),
              onTap: () {
                onPageChange(3);
              },
            ),
            ListTile(
              leading: const Icon(Icons.message),
              title: const Text('Bate Papo'),
              onTap: () {
                onPageChange(4);
              },
            ),
            Expanded(
              child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: const Icon(Icons.logout),
                    iconColor: Pallete.redColor,
                    title: const Text('Deslogar',
                        style: TextStyle(color: Pallete.redColor)),
                    onTap: () {
                      authUser().deslogar();
                    },
                  ),
                ),
              ),
            ),
          ]),
        ),
        Container(
          height: double.infinity,
          width: 0.5, // Largura da linha vertical
          color: Pallete.borderColor, // Cor da linha vertical
          margin: const EdgeInsets.symmetric(vertical: 8.0), // Margem vertical
        ),
        //rest of the body
        SizedBox(
            width: 600,
            height: double.infinity,
            child: _page != 10
                ? IndexedStack(index: _page, children: AssetsConstants.pagesweb)
                : Scaffold(
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
                                                  builder: (context) =>
                                                      EditProfile(),
                                                ));
                                          },
                                          child: const Icon(
                                              Icons.create_outlined)),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.all(8.0)
                                          .copyWith(left: 15, right: 15),
                                      child: GestureDetector(
                                          onTap: () {
                                            _chatService.createChatRoom(
                                                user.displayName.toString(),
                                                widget.nome);
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ChatPage(
                                                          receiverUserID:
                                                              widget.nome),
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
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          EditProfile(),
                                                    ));
                                              },
                                              child: const Icon(
                                                  Icons.create_outlined)),
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
                                                    user.displayName.toString(),
                                                    widget.nome);
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          ChatPage(
                                                              receiverUserID:
                                                                  widget.nome),
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
                                    future: database
                                        .getBioByPerfil(user!.email.toString()),
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
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
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
                                      child: Text(
                                          'Este usuario ainda não tem nenhum post'),
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
                                          1);
                                    },
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  )),
        Container(
          height: double.infinity,
          width: 0.5, // Largura da linha vertical
          color: Pallete.borderColor, // Cor da linha vertical
          margin: const EdgeInsets.symmetric(vertical: 8.0), // Margem vertical
        ),
      ]),
    );
  }
}

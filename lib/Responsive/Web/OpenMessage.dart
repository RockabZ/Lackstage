import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lackstage/Constants.dart';
import 'package:lackstage/Pallete.dart';
import 'package:lackstage/Services/Firebase/AddPost_Controller.dart';
import 'package:lackstage/Services/Firebase/Auth.dart';
import 'package:lackstage/Services/Firebase/GetPosts.dart';
import 'package:lackstage/ui/PostCard.dart';

class OpenMessageWeb extends StatefulWidget {
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
  final int numero;
  const OpenMessageWeb(
      {super.key,
      required this.nome,
      required this.id,
      required this.text,
      required this.curtidas,
      required this.reposts,
      required this.comentarios,
      required this.timestamp,
      required this.repliedto,
      required this.autorReply,
      required this.aimage,
      this.numero = 0});

  @override
  State<OpenMessageWeb> createState() => _DesktopHomePageState();
}

class _DesktopHomePageState extends State<OpenMessageWeb> {
  int _page = 11;
  void onPageChange(int index) {
    setState(() {
      _page = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController texto = TextEditingController();
    PostController postar = PostController();
    final GetPosts database = GetPosts();
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
            child: _page != 11
                ? IndexedStack(index: _page, children: AssetsConstants.pagesweb)
                : Scaffold(
                    body: Column(
                      children: [
                        postCard(
                            widget.id,
                            widget.nome,
                            widget.text,
                            widget.curtidas,
                            widget.reposts,
                            widget.comentarios,
                            widget.timestamp,
                            context,
                            widget.repliedto,
                            widget.autorReply,
                            widget.aimage,
                            1),
                        StreamBuilder(
                          stream: database.getRepliesPostsStream(widget.id),
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
                                      'Nenhum comentário no momento... Comente algo'),
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
                                      aimage,
                                      1);
                                },
                              ),
                            );
                          },
                        )
                      ],
                    ),
                    bottomNavigationBar: TextField(
                        controller: texto,
                        onSubmitted: (value) {
                          postar.SharePost(
                              repliedto: widget.id,
                              images: [],
                              text: value,
                              context: context,
                              autorreply: widget.nome,
                              numero: 1);
                          texto.clear();
                        },
                        decoration: const InputDecoration(
                            hintText: 'Poste sua reposta')),
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

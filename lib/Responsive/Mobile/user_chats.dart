import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lackstage/Pallete.dart';
import 'package:lackstage/Responsive/Mobile/chat_page.dart';
import 'package:lackstage/Responsive/Web/web_chat.dart';
import 'package:lackstage/Services/Firebase/GetPosts.dart';

class UserChats extends StatelessWidget {
  final int number;
  UserChats({super.key, required this.number});

  @override
  Widget build(BuildContext context) {
    final GetPosts database = GetPosts();
    User? user = FirebaseAuth.instance.currentUser;

    return Column(
      children: [
        StreamBuilder(
          stream: database.getAllPerfils(user!.displayName.toString()),
          builder: (context, snapshot) {
            //show loading circle
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            //get all perfi
            final perfis = snapshot.data!.docs;
            //no data
            if (snapshot.data == null || perfis.isEmpty) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(25),
                  child: Text('Nenhum perfil encontrado'),
                ),
              );
            }

            // return as a list
            return Expanded(
              child: ListView.builder(
                itemCount: perfis.length,
                itemBuilder: (context, index) {
                  // get individual perfil
                  final perfil = perfis[index];

                  // get data from each perfil
                  String user = perfil['NomeUsuario'];
                  String image = perfil['Image'];
                  String bio = perfil['Bio'];
                  // return as a list tile

                  return Column(
                    children: [
                      if (index == 0)
                        const SizedBox(
                          height: 20,
                        ),
                      if (index == 0) const Text('Pessoas'),
                      GestureDetector(
                        onTap: () {
                          number == 0
                              ? Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ChatPage(receiverUserID: user)))
                              : Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => WebChat(
                                      receiverUserID: user,
                                    ),
                                  ));
                        },
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(image),
                            radius: 30,
                          ),
                          title: Text(
                            user,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                bio,
                                style:
                                    const TextStyle(color: Pallete.whiteColor),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}

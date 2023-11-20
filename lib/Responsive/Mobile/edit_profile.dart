import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lackstage/Pallete.dart';
import 'package:lackstage/Services/Firebase/Auth.dart';
import 'package:lackstage/Services/Firebase/GetPosts.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final authUser _authUser = authUser();

    final GetPosts database = GetPosts();
    User? user = FirebaseAuth.instance.currentUser;
    TextEditingController _nomeController = TextEditingController();
    TextEditingController _bioController = TextEditingController();
    final appBarTextFieldBorder = OutlineInputBorder(
        borderRadius: BorderRadius.circular(50),
        borderSide: const BorderSide(color: Pallete.borderColor));

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Pallete.backgroundColor,
          centerTitle: true,
          title: const Text('Editar Perfil'),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0).copyWith(left: 15, right: 15),
              child: GestureDetector(
                  onTap: () {
                    final String nome = _nomeController.text;
                    final String bio = _bioController.text;

                    _authUser.updateBio(
                        nome, bio, user!.email.toString(), context, 0);
                  },
                  child: const Icon(Icons.check)),
            )
          ]),
      body: FutureBuilder(
        future: database.getPerfil(user!.email.toString()),
        builder: (context, snapshot) {
          //show loading circle
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          String image = snapshot.data['Image'];
          String bio = snapshot.data['Bio'];
          String nome = snapshot.data['NomeUsuario'];
          _nomeController = TextEditingController(text: nome);
          _bioController = TextEditingController(text: bio);

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const SizedBox(height: 25),
                CircleAvatar(
                  backgroundImage: NetworkImage(image),
                  radius: 45,
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  'Nome de Usuario',
                  style: TextStyle(color: Pallete.whiteColor, fontSize: 20),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: _nomeController,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(10).copyWith(left: 20),
                    fillColor: Pallete.borderColor,
                    filled: true,
                    enabledBorder: appBarTextFieldBorder,
                    focusedBorder: appBarTextFieldBorder,
                    hintText: 'Pesquisar Posts',
                  ),
                  enabled: false,
                ),
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  'Bio',
                  style: TextStyle(color: Pallete.whiteColor, fontSize: 20),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: _bioController,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(10).copyWith(left: 20),
                    fillColor: Pallete.borderColor,
                    filled: true,
                    enabledBorder: appBarTextFieldBorder,
                    focusedBorder: appBarTextFieldBorder,
                    hintText: 'Conte-nos mais sobre você',
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:lackstage/Pallete.dart';
import 'package:lackstage/Services/Firebase/GetPosts.dart';
import 'package:lackstage/ui/search_tile.dart';

class ExploreViewWeb extends StatefulWidget {
  const ExploreViewWeb({super.key});

  @override
  State<ExploreViewWeb> createState() => _ExploreViewState();
}

class _ExploreViewState extends State<ExploreViewWeb> {
  final searchController = TextEditingController();
  String pesquisa = '';
  final GetPosts database = GetPosts();
  final appBarTextFieldBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(50),
      borderSide: const BorderSide(color: Pallete.borderColor));
  void pesquisar(String nome) {
    setState(() {
      pesquisa = nome;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Pallete.backgroundColor,
        title: SizedBox(
          height: 50,
          child: TextField(
            onSubmitted: (value) {
              pesquisar(value);
            },
            controller: searchController,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.all(10).copyWith(left: 20),
              fillColor: Pallete.borderColor,
              filled: true,
              enabledBorder: appBarTextFieldBorder,
              focusedBorder: appBarTextFieldBorder,
              hintText: 'Pesquisar Posts',
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          pesquisa.isEmpty
              ? const Center(
                  child: Padding(
                      padding: EdgeInsets.all(25),
                      child: Text('Faça uma pesquisa')),
                )
              : StreamBuilder(
                  stream: database.getPerfilsBySearch(searchController.text),
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

                          return SearchTile(
                            nome: user,
                            image: image,
                            bio: bio,
                            number: 1,
                          );
                        },
                      ),
                    );
                  },
                ),
        ],
      ),
    );
  }
}

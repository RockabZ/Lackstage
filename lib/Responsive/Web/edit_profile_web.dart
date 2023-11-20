import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lackstage/Constants.dart';
import 'package:lackstage/Pallete.dart';
import 'package:lackstage/Services/Firebase/Auth.dart';
import 'package:lackstage/Services/Firebase/GetPosts.dart';

class EditProfileWeb extends StatefulWidget {
  const EditProfileWeb({super.key});

  @override
  State<EditProfileWeb> createState() => _DesktopHomePageState();
}

class _DesktopHomePageState extends State<EditProfileWeb> {
  int _page = 13;
  void onPageChange(int index) {
    setState(() {
      _page = index;
    });
  }

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
        appBar: myAppBar,
        body: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          //open drawer
          Drawer(
            width: 250,
            elevation: 0,
            backgroundColor: Pallete.backgroundColor,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
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
            margin:
                const EdgeInsets.symmetric(vertical: 8.0), // Margem vertical
          ),
          //rest of the body
          SizedBox(
            width: 600,
            height: double.infinity,
            child: _page != 13
                ? IndexedStack(index: _page, children: AssetsConstants.pagesweb)
                : Scaffold(
                    body: Column(
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0)
                                .copyWith(left: 15, right: 15),
                            child: GestureDetector(
                                onTap: () {
                                  final String nome = _nomeController.text;
                                  final String bio = _bioController.text;

                                  _authUser.updateBio(nome, bio,
                                      user!.email.toString(), context, 1);
                                },
                                child: const Icon(Icons.check)),
                          ),
                        ),
                        FutureBuilder(
                          future: database.getPerfil(user!.email.toString()),
                          builder: (context, snapshot) {
                            //show loading circle
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
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
                                    style: TextStyle(
                                        color: Pallete.whiteColor,
                                        fontSize: 20),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  TextFormField(
                                    controller: _nomeController,
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.all(10)
                                          .copyWith(left: 20),
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
                                    style: TextStyle(
                                        color: Pallete.whiteColor,
                                        fontSize: 20),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  TextFormField(
                                    controller: _bioController,
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.all(10)
                                          .copyWith(left: 20),
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
                      ],
                    ),
                  ),
          )
        ]));
  }
}

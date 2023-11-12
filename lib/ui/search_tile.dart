import 'package:flutter/material.dart';
import 'package:lackstage/Pages/user_profile.dart';
import 'package:lackstage/Pallete.dart';

class SearchTile extends StatelessWidget {
  final String nome;
  final String image;
  final String bio;
  const SearchTile(
      {super.key, required this.nome, required this.image, required this.bio});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UserProfile(nome: nome, image: image),
            ));
      },
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(image),
          radius: 30,
        ),
        title: Text(
          nome,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              bio,
              style: const TextStyle(color: Pallete.whiteColor),
            ),
          ],
        ),
      ),
    );
  }
}

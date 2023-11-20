import 'package:flutter/material.dart';
import 'package:lackstage/Responsive/Mobile/user_profile.dart';
import 'package:lackstage/Pallete.dart';
import 'package:lackstage/Responsive/Web/userprof.dart';

class SearchTile extends StatelessWidget {
  final String nome;
  final String image;
  final String bio;
  final int number;
  const SearchTile(
      {super.key,
      required this.nome,
      required this.image,
      required this.bio,
      this.number = 0});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        number == 0
            ? Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserProfile(
                    nome: nome,
                    image: image,
                    bio: bio,
                    numero: number,
                  ),
                ))
            : Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => UserClickedProfile(
                    nome: nome,
                    image: image,
                    bio: bio,
                    numero: number,
                  ),
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

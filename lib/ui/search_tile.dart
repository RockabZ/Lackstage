import 'package:flutter/material.dart';
import 'package:lackstage/Pages/user_profile.dart';
import 'package:lackstage/Pallete.dart';

class SearchTile extends StatelessWidget {
  final String nome;
  const SearchTile({super.key, required this.nome});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UserProfile(nome: nome),
            ));
      },
      child: ListTile(
        leading: const CircleAvatar(
          backgroundImage: NetworkImage(
              'https://cdn-icons-png.flaticon.com/512/1816/1816466.png'),
          radius: 30,
        ),
        title: Text(
          nome,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        subtitle: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'bioluminescencia',
              style: TextStyle(color: Pallete.whiteColor),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lackstage/Pallete.dart';

class PostIconButton extends StatelessWidget {
  final String pathname;
  final String text;
  final VoidCallback onTap;
  const PostIconButton(
      {super.key,
      required this.pathname,
      required this.text,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          SvgPicture.asset(
            pathname,
            color: Pallete.borderColor,
          ),
          Container(
            margin: const EdgeInsets.all(6),
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                color: Pallete.greyColor,
              ),
            ),
          )
        ],
      ),
    );
  }
}

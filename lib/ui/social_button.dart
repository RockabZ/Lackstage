import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../Pallete.dart';

class SocialButton extends StatelessWidget {
  final String iconPath;
  final VoidCallback onPressed;
  const SocialButton({
    super.key,
    required this.iconPath,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: SvgPicture.asset(
        iconPath,
        color: Pallete.whiteColor,
      ),
    );
  }
}

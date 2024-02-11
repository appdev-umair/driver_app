import 'package:flutter/material.dart';
import 'package:flutter_social_button/flutter_social_button.dart';

class SocialButtons extends StatelessWidget {
  const SocialButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {},
          icon: const Icon(FontAwesomeIcons.google),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(FontAwesomeIcons.facebook),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(FontAwesomeIcons.instagram),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          'assets/branding/app_icon.png',
          width: 90,
          height: 90,
          errorBuilder: (context, error, stackTrace) {
            return const Icon(
              Icons.restaurant_menu,
              size: 80,
              color: Colors.white,
            );
          },
        ),
        const SizedBox(height: 10),
        const Text(
          'CookCraft',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Your personal cookbook',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white38,
          ),
        ),
      ],
    );
  }
}

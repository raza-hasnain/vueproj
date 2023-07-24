import 'package:flutter/material.dart';

class LoginBackground extends StatelessWidget {
  const LoginBackground({super.key});

  @override
  Widget build(BuildContext context){
    return ShaderMask(
      shaderCallback: (bounds) => const LinearGradient(
        colors: [Color(0xFF2B2B2B), Color(0xFF2B2B2B)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(bounds),
      blendMode: BlendMode.hardLight,
      child: Container(
        // BACKGROUND IMAGE
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background/dubaibg.jpg"),
            fit: BoxFit.cover,
            // colorFilter: ColorFilter.mode(Colors.white38, BlendMode.darken),
          ),
        ),
      ),
    );
  }
}
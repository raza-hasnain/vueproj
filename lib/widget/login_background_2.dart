import 'package:flutter/material.dart';

class LoginBackground2 extends StatelessWidget {
  const LoginBackground2({super.key});

  @override
  Widget build(BuildContext context){
    return
      // ShaderMask(
      // shaderCallback: (bounds) => const LinearGradient(
      //   colors: [Color(0xFF283962), Color(0xFF283962)],
      //   begin: Alignment.topCenter,
      //   end: Alignment.center,
      // ).createShader(bounds),
      // blendMode: BlendMode.hardLight,
      // child:
      Container(
        // BACKGROUND IMAGE
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background/bgbg.png"),
            fit: BoxFit.cover,
            // colorFilter: ColorFilter.mode(Colors.white38, BlendMode.darken),
          ),
        ),
      // ),
    );
  }
}
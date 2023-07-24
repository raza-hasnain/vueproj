import 'package:flutter/material.dart';

class HeaderBar extends StatelessWidget {
  const HeaderBar({super.key});

  @override
  Widget build(BuildContext context) => AppBar(
      // title: Row(
      //   children: const [
      //     Expanded(
      //       flex: 0,
      //       child: Text(""),
      //     ),
      //     Expanded(
      //       flex: 5,
      //       child: Image(
      //         image: AssetImage("assets/images/logo/fullLogoRE.png"),
      //         height: 40,
      //       ),
      //     ),
      //     Expanded(
      //       flex: 1,
      //       child: CircleAvatar(
      //         radius: 20,
      //         backgroundImage: AssetImage(
      //           "assets/images/logo/hikalagency-icon.png",
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
      // // const Image(
      // //   image: AssetImage("assets/images/logo/fullLogoRE.png"),
      // //   height: 40,
      // // // const Text(
      // // //   "Dashboard",
      // // //   style: TextStyle(
      // // //     color: Colors.blue,
      // // //   ),
      // // ),
      // backgroundColor: Colors.white,
      // // automaticallyImplyLeading: false,
      // iconTheme: const IconThemeData(
      //   color: Colors.grey,
      // ),

    // shape: ShapeBorder.lerp(
    //   const RoundedRectangleBorder(
    //     borderRadius: BorderRadius.only(
    //       bottomLeft: Radius.circular(30),
    //       bottomRight: Radius.circular(30),
    //     ),
    //   ),
    //   null,
    //   0,
    // ),
    elevation: 0,
    title: const Image(
      image: AssetImage("assets/images/logo/fullLogoRE.png"),
      height: 40,
    ),
    backgroundColor: const Color(0xFFF3EDEB),
    // automaticallyImplyLeading: false,
    iconTheme: const IconThemeData(
      color: Color(0xFF133465),
    ),
    actions: [
      Center(
        child: Row(
          children: const [
            IconButton(
              icon: Icon(Icons.notifications_none_outlined),
              onPressed:  null,
            ),
            CircleAvatar(
              backgroundImage: AssetImage("assets/images/logo/hikalagency-icon.png"),
              radius: 17.0,
            ),
            SizedBox(
              width: 11,
            ),
          ],
        ),
      ),
    ],
  );
}
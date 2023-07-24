import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../utils/assets.dart';

class LoaderDialogContent extends StatelessWidget {
  const LoaderDialogContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Center(
      child: SizedBox(
        width: 170,
        height: 170,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(dark ? lightLoading : darkLoading, fit: BoxFit.cover),
            Text(
              "Loading",
              style: TextStyle(color: Colors.red),
            )
          ],
        ),
      ),
    );
  }
}

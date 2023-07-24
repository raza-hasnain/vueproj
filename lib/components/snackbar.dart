import 'package:flutter/material.dart';

snackBar(
  BuildContext context,
  String mainText,
  Color backgroundColor,
) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(mainText),
    backgroundColor: backgroundColor,
  ));
}

snackBar1(
  BuildContext context,
  String mainText,
  Color backgroundColor,
  Color ? color
) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(mainText ,style: TextStyle(color: color),),
    backgroundColor: backgroundColor,
  ));
}
  
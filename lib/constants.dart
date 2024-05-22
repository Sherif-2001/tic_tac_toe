import 'package:flutter/material.dart';

final customElevatedButtonThemeData = ElevatedButton.styleFrom(
    backgroundColor: Colors.blueGrey[800],
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
    shape: RoundedRectangleBorder(
      side: const BorderSide(color: Colors.white, width: 3),
      borderRadius: BorderRadius.circular(10),
    ),
    textStyle: const TextStyle(fontSize: 25, fontFamily: "GillSans"));

final customDialogTheme = DialogTheme(
  titleTextStyle: const TextStyle(
      color: Colors.white, fontSize: 35, fontFamily: "GillSans"),
  backgroundColor: Colors.blueGrey[900],
  shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
      side: const BorderSide(color: Colors.white, width: 1)),
);

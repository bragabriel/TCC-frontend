import 'package:flutter/material.dart';

class TextBuilder{
  static Text buildText(String? text) {
  return Text(
    "$text \n",
    style: const TextStyle(
      color: Colors.black,
      fontSize: 18,
    ),
  );
}
}
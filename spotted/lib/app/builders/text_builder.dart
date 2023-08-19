import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TextHelper{
  static Text buildText(String? text) {
  return Text(
    "$text \n",
    style: TextStyle(
      color: Colors.black,
      fontSize: 18,
    ),
  );
}
}
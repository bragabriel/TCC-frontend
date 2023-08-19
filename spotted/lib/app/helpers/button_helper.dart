import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ButtonHelper{
  static Column newButton(Color color, IconData icon, String? textBase, String? dado) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.end,
    children: <Widget>[
      IconButton(
        icon: Icon(icon, color: color, size: 50),
        onPressed: () => _openURL(textBase! + dado!),
      ),
      SizedBox(height: 20),
    ],
  );
}

static void _openURL(String url) async {
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url));
  } else {
    throw 'Não foi possível abrir $url';
  }
}

}
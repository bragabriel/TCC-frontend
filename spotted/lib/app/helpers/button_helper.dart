import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ButtonHelper {
  static FilledButton newButton(
    Color color,
    String? textBase,
    String? dado,
    String? textButton,
  ) {
    return FilledButton(
      onPressed: () => _openURL(textBase! + dado!),
      child: Text(textButton!),
    );
  }

  static _openURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Não foi possível abrir $url';
    }
  }
}

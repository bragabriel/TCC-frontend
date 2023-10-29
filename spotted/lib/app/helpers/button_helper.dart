import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ButtonHelper {
  static Container newButton(Color color, IconData icon, String? textBase,
      String? dado, String textButton) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.deepPurple, // Set the border color
          width: 2.0, // Set the border width
        ),
        color: Colors.deepPurple,

        borderRadius: BorderRadius.circular(30.0), // Set border radius
      ),
      child: CupertinoButton(
        onPressed: () => _showActionSheet(textBase, dado),
        child: Text(
        textButton,
        style: const TextStyle(
          color: Colors.white, 
        ),
      ),
      ),
    );
  }

  static CupertinoActionSheet _showActionSheet(String? textBase, String? dado) {
    return CupertinoActionSheet(
      title: const Text('Title'),
      message: const Text('Message'),
      actions: <CupertinoActionSheetAction>[
        CupertinoActionSheetAction(
          /// This parameter indicates the action would be a default
          /// default behavior, turns the action's text to bold text.
          isDefaultAction: true,
          onPressed: () {
            // Navigator.pop(context);
          },
          child: const Text('Default Action'),
        ),
        CupertinoActionSheetAction(
          onPressed: () {
            () => _openURL(textBase! + dado!);
          },
          child: const Text('Action'),
        ),
        CupertinoActionSheetAction(
          /// This parameter indicates the action would perform
          /// a destructive action such as delete or exit and turns
          /// the action's text color to red.
          isDestructiveAction: true,
          onPressed: () {
            // () => _openURL(textBase! + dado!);
          },
          child: const Text('Destructive Action'),
        ),
      ],
    );
  }

  static void _openURL(String url) async {
    if (await canLaunch(url)) {
      // Use canLaunch instead of canLaunchUrl
      await launch(url); // Use launch instead of launchUrl
    } else {
      throw 'Não foi possível abrir $url';
    }
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Cupertino Popup Menu'),
      ),
      child: Center(
        child: CupertinoContextMenu(
          actions: <Widget>[
            CupertinoContextMenuAction(
              child: Text('Option 1'),
              onPressed: () {
                // Implement the action for Option 1 here
              },
            ),
            CupertinoContextMenuAction(
              child: Text('Option 2'),
              onPressed: () {
                // Implement the action for Option 2 here
              },
            ),
          ],
          child: Container(
            color: CupertinoColors.systemGrey,
            width: 200,
            height: 200,
            child: Center(
              child: Text('Long press me'),
            ),
          ),
        ),
      ),
    );
  }
}

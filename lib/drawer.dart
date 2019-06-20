import 'package:flutter/material.dart';

class DrawerMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        ListTile(title: Text("hoge"),
        onTap: () {
          Navigator.of(context).pop();
        },
        )
      ],
    );
  }
}
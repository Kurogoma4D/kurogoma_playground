import 'package:flutter/material.dart';
import 'pages/widgets.dart';
import 'pages/ideas.dart';

class DrawerMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        ListTile(
          title: Text("HOME"),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => IdeasPage()));
          },
        ),
        ListTile(
          title: Text("WIDGETS"),
          onTap: () {
            Navigator.of(context).pop();
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => WidgetTest()));
          },
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'pages/widgets.dart';

class DrawerMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        ListTile(
          title: Text("hoge"),
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

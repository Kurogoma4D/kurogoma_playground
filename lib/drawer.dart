import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_model.dart';

class DrawerMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        ListTile(
          title: Text("HOME"),
          onTap: () {
            Navigator.of(context).pop();
            Provider.of<AppStateModel>(context).setPage(0);
          },
        ),
        ListTile(
          title: Text("WIDGETS"),
          onTap: () {
            Navigator.of(context).pop();
            Provider.of<AppStateModel>(context).setPage(1);
          },
        )
      ],
    );
  }
}

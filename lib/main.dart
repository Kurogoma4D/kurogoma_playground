import 'package:KRPG/app_model.dart';
import 'package:KRPG/pages/widgets.dart';

import 'drawer.dart';
import 'package:flutter/material.dart';
import 'pages/ideas.dart';
import 'custom_theme.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:provider/provider.dart';
import 'app_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themeData,
      home: Stack(
        children: <Widget>[
          SizedBox.expand(
            child: FlareActor(
              "assets/starry_sky.flr",
              animation: "stars",
              alignment: Alignment.center,
              fit: BoxFit.fitHeight,
            ),
          ),
          ChangeNotifierProvider<AppStateModel>(
            builder: (_) => AppStateModel(0),
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                title: Text("IDEAS"),
              ),
              drawer: Drawer(
                child: DrawerMenu(),
              ),
              body: _selectPage(context),
              backgroundColor: Colors.transparent,
              floatingActionButton: FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: () {},
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ページ増やしたらこれ追加しないといけない
  Widget _selectPage(BuildContext context) {
    Widget page;
    switch (Provider.of<AppStateModel>(context).pageIndex) {
      case 0:
        page = IdeasPage();
        break;
      case 1:
        page = WidgetTestPage();
        break;
    }
    return page;
  }
}

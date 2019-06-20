import 'package:flutter/material.dart';
import 'pages/ideas.dart';
import 'custom_theme.dart';
import 'package:flare_flutter/flare_actor.dart';

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
          Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0.0,
              title: Text("IDEAS"),
            ),
            drawer: Drawer(
            ),
            body: IdeasPage(),
            backgroundColor: Colors.transparent,
            floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}

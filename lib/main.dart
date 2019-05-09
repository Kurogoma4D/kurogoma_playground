import 'package:flutter/material.dart';
import 'ideas.dart';
import 'custom-theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: themeData,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: Text("IDEAS"),
        ),
        drawer: Drawer(),
        body: IdeasPage(),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: (){},
        ),
      ),
    );
  }
}

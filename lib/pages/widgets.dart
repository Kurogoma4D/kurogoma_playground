import 'package:flutter/material.dart';

class WidgetTestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ListView(
        children: <Widget>[
          Showcase(
            title: 'NeumorphismicButtons',
            children: <Widget>[],
          ),
        ],
      ),
    );
  }
}

class Showcase extends StatelessWidget {
  final String title;
  final List<Widget> children;

  const Showcase({Key key, this.title, this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              this.title,
              style: Theme.of(context).textTheme.title,
            ),
            const SizedBox(height: 12),
            Row(
              children: this.children,
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class WidgetTestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ListView(
        children: <Widget>[
          _neumorphismicButtons(context),
        ],
      ),
    );
  }

  Widget _neumorphismicButtons(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'NeumorphismicButtons',
              style: Theme.of(context).textTheme.title,
            ),
            const SizedBox(height: 12),
            Row(
              children: <Widget>[],
            )
          ],
        ),
      ),
    );
  }
}

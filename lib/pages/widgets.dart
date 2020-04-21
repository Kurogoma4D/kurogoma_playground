import 'package:KRPG/components/neumorphismic_button.dart';
import 'package:flutter/material.dart';

class WidgetTestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const _baseColor = Color(0xFFF2F2F2);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ListView(
        children: <Widget>[
          Showcase(
            title: 'NeumorphismicButtons',
            baseColor: _baseColor,
            children: <Widget>[
              NeumorphismicButton(),
              const SizedBox(width: 20),
              NeumorphismicButton(),
              const SizedBox(width: 20),
              NeumorphismicButton(),
            ],
          ),
        ],
      ),
    );
  }
}

class Showcase extends StatelessWidget {
  final String title;
  final List<Widget> children;
  final Color baseColor;

  const Showcase({Key key, this.title, this.children, this.baseColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: this.baseColor,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              this.title,
              style: Theme.of(context).textTheme.headline6,
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

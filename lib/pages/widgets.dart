import 'package:flutter/material.dart';

class WidgetTestPage extends StatefulWidget {
  @override
  _WidgetTestPageState createState() => _WidgetTestPageState();
}

class _WidgetTestPageState extends State<WidgetTestPage> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 5,
      itemBuilder: _buildListItem,
      separatorBuilder: (context, index) => Divider(),
    );
  }

  Widget _buildListItem(BuildContext context, int index) {
    return Card(
      child: Placeholder(fallbackHeight: 100,),
    );
  }
}

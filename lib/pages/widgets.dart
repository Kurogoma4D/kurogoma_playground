import 'package:flutter/material.dart';

class WidgetTestPage extends StatelessWidget {
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
      child: Placeholder(
        fallbackHeight: 100,
      ),
    );
  }
}

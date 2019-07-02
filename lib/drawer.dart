import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_model.dart';

class DrawerMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppStateModel>(builder: (context, _model, _child) {
      return ListView.builder(
        itemCount: _model.pages.length,
        itemBuilder: (context, _index) => ListTile(
              title: Text(_model.pages[_index]),
              onTap: () {
                Navigator.of(context).pop();
                _model.setPage(_index);
              },
            ),
      );
    });
  }
}

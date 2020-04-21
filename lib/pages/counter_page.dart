import 'package:KRPG/states/counter/counter.dart';
import 'package:KRPG/states/counter/counter_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          '${context.select((Counter c) => c.count)}'
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: context.watch<CounterController>().increment,
      ),
    );
  }
}

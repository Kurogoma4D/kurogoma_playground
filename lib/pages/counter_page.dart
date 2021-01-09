import 'package:KRPG/states/counter/counter_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';

class CounterPage extends ConsumerWidget {
  const CounterPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final counterState = watch(counterControllerProvider.state);
    return Scaffold(
      body: Center(
        child: Text('${counterState.count}'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => context.read(counterControllerProvider).increment(),
      ),
    );
  }
}

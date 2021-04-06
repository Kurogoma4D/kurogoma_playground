import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/all.dart';

final random = math.Random();

String simpleFunction() => 'foo';

Provider<int> generateProvider<T>() => Provider((_) => random.nextInt(50000));

final _generated = generateProvider<int>();

class FunctionMacroPage extends StatelessWidget {
  const FunctionMacroPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const _Contents();
}

class _Contents extends StatefulWidget {
  const _Contents({Key key}) : super(key: key);

  @override
  __ContentsState createState() => __ContentsState();
}

class __ContentsState extends State<_Contents> {
  int providedValue = 0;

  void _reflectGeneratedValue() {
    setState(() {
      providedValue = context.read(_generated);
    });
  }

  void _generateProvider() {
    setState(() {
      providedValue = context.read(generateProvider());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(providedValue.toString()),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: _reflectGeneratedValue,
            child: Text('Generated'),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _generateProvider,
            child: Text('Generate new Provider'),
          ),
        ],
      ),
    );
    ;
  }
}

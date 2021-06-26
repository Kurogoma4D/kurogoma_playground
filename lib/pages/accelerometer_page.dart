import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:sensors_plus/sensors_plus.dart';

final accelerometerPageControllerProvider =
    ChangeNotifierProvider((_) => AccelerometerPageController());

@immutable
class AccelerometerEventString {
  final String x;
  final String y;
  final String z;

  AccelerometerEventString(this.x, this.y, this.z);
}

class AccelerometerPage extends StatelessWidget {
  const AccelerometerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: const _AccelerometerView(),
      ),
    );
  }
}

class _AccelerometerView extends ConsumerWidget {
  const _AccelerometerView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final controller = watch(accelerometerPageControllerProvider);
    if (controller.accelerometerStream == null) return SizedBox.shrink();

    return StreamBuilder<AccelerometerEventString>(
      stream: controller.accelerometerStream,
      builder: (context, snapshot) => Text(
          'x: ${snapshot.data?.x} y: ${snapshot.data?.y} z: ${snapshot.data?.z}'),
    );
  }
}

class AccelerometerPageController extends ChangeNotifier {
  Stream<AccelerometerEventString>? accelerometerStream;

  AccelerometerPageController() {
    accelerometerStream = accelerometerEvents.map(
      (event) => AccelerometerEventString(
        event.x.toStringAsFixed(2),
        event.y.toStringAsFixed(2),
        event.z.toStringAsFixed(2),
      ),
    );
  }
}

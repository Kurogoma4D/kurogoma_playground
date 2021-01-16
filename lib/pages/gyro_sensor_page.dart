import 'package:flutter/material.dart';
import 'package:flutter_riverpod/all.dart';
import 'package:sensors_plus/sensors_plus.dart';

final gyroSensorPageControllerProvider =
    ChangeNotifierProvider((_) => GyroSensorPageController());

@immutable
class GyroScopeEventString {
  final String x;
  final String y;
  final String z;

  GyroScopeEventString(this.x, this.y, this.z);
}

class GyroSensorPage extends StatelessWidget {
  const GyroSensorPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: const _GyroSensorView(),
      ),
    );
  }
}

class _GyroSensorView extends ConsumerWidget {
  const _GyroSensorView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final controller = watch(gyroSensorPageControllerProvider);
    if (controller.gyroStream == null) return SizedBox.shrink();

    return StreamBuilder<GyroScopeEventString>(
      stream: controller.gyroStream,
      builder: (context, snapshot) => Text(
          'x: ${snapshot.data?.x} y: ${snapshot.data?.y} z: ${snapshot.data?.z}'),
    );
  }
}

class GyroSensorPageController extends ChangeNotifier {
  Stream<GyroScopeEventString> gyroStream;

  GyroSensorPageController() {
    gyroStream = gyroscopeEvents.map(
      (event) => GyroScopeEventString(
        event.x.toStringAsFixed(2),
        event.y.toStringAsFixed(2),
        event.z.toStringAsFixed(2),
      ),
    );
  }
}

import 'dart:math';

import 'package:flutter/material.dart';

class PhysicsEngine {
  Offset position = _initialPosition;
  double _t = 0.0;

  static final _initialPosition = Offset(100.0, 100.0);
  static final _ground = 440.0;
  final _g = 9.8;

  void initialize() {
    position = Offset(_initialPosition.dx, _initialPosition.dy);
    _t = 0.0;
  }

  void setStateAt(double time) {
    final t = time * 1000 - _t;

    double a = _g;

    if (position.dy > _ground) {
      a -= 0.6 * (position.dy - _ground);
    }

    final velocity = a * t;
    final heightByEp = _initialPosition.dy + velocity * t;
    position = Offset(_initialPosition.dx + t, heightByEp);
    _t = t;
  }
}

class PhysicsPage extends StatelessWidget {
  const PhysicsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const _Contents();
  }
}

class _Contents extends StatefulWidget {
  const _Contents({Key key}) : super(key: key);

  @override
  __ContentsState createState() => __ContentsState();
}

class __ContentsState extends State<_Contents>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  PhysicsEngine engine;

  @override
  void initState() {
    engine = PhysicsEngine();
    controller =
        AnimationController(vsync: this, duration: Duration(minutes: 1))
          ..addListener(() {
            engine.setStateAt(controller.value);
          });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Spacer(),
        AnimatedBuilder(
          animation: controller,
          builder: (context, _) => CustomPaint(
            painter: _PhysicsPainter(position: engine.position),
            size: Size(
              MediaQuery.of(context).size.width,
              500,
            ),
          ),
        ),
        const SizedBox(height: 32),
        ElevatedButton(
          onPressed: () {
            engine.initialize();
            controller.forward(from: 0.0);
          },
          child: Text('START'),
        ),
        Spacer(),
      ],
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class _PhysicsPainter extends CustomPainter {
  final Offset position;

  _PhysicsPainter({this.position});

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..color = Colors.white,
    );
    canvas.drawCircle(position, 40, Paint()..color = Colors.teal);
  }

  @override
  bool shouldRepaint(covariant _PhysicsPainter oldDelegate) =>
      position != oldDelegate.position;
}

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AnimatedNeumorphismicContainer extends StatelessWidget {
  final double depth;
  final Color baseColor;

  const AnimatedNeumorphismicContainer(
      {Key key, @required this.depth, this.baseColor})
      : super(key: key);

  static final _curve = Curves.easeInOut;

  @override
  Widget build(BuildContext context) {
    final _tween = Tween<double>(begin: 0, end: depth);
    return TweenAnimationBuilder(
      tween: _tween,
      duration: const Duration(milliseconds: 250),
      curve: _curve,
      builder: (BuildContext context, double depthValue, Widget child) {
        return Container(
          width: 60,
          height: 60,
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: this.baseColor,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                offset: _lerpedOffset(depthValue),
                color: _lerpedColor(depthValue),
                blurRadius: lerpDouble(8, 6, depthValue),
                spreadRadius: lerpDouble(4, -4, depthValue),
              ),
              BoxShadow(
                offset: _lerpedOffset(1.0 - depthValue),
                color: _lerpedColor(1.0 - depthValue),
                blurRadius: lerpDouble(6, 8, depthValue),
                spreadRadius: lerpDouble(4, -4, depthValue),
              ),
            ],
          ),
          child: child,
        );
      },
      child: Icon(Icons.access_time),
    );
  }

  Offset _lerpedOffset(double t) {
    final begin = const Offset(-4, -4);
    final end = const Offset(4, 4);
    return Offset.lerp(begin, end, t);
  }

  Color _lerpedColor(double t) {
    final begin = Color.fromRGBO(255, 255, 255, 1);
    final end = Color.fromRGBO(55, 84, 170, 0.2);
    return Color.lerp(begin, end, t);
  }
}

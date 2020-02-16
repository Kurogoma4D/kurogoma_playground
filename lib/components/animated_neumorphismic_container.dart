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
    final _lightColor = _createLightColor();
    final _darkColor = _createDarkColor();
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
            gradient: LinearGradient(
              colors: [
                _darkColor,
                this.baseColor,
                _lightColor,
              ],
              stops: [0, 0.2, 0.8],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                offset: _lerpedOffsetLight(depthValue),
                color: _lightColor,
                blurRadius: lerpDouble(4, 0.5, depthValue),
                spreadRadius: lerpDouble(2, 1, depthValue),
              ),
              BoxShadow(
                offset: _lerpedOffsetDark(depthValue),
                color: _darkColor,
                blurRadius: lerpDouble(4, 0.5, depthValue),
                spreadRadius: lerpDouble(2, 1, depthValue),
              ),
            ],
          ),
          child: child,
        );
      },
      child: Icon(Icons.access_time),
    );
  }

  Offset _lerpedOffsetLight(double t) {
    //TODO: サイズに比例させる
    final begin = const Offset(-6, -6);
    final end = const Offset(-2, -2);
    return Offset.lerp(begin, end, t);
  }

  Offset _lerpedOffsetDark(double t) {
    //TODO: サイズに比例させる
    final begin = const Offset(6, 6);
    final end = const Offset(2, 2);
    return Offset.lerp(begin, end, t);
  }

  Color _createLightColor() {
    final hsv = HSVColor.fromColor(this.baseColor);
    final newValue = (hsv.value + 0.2).clamp(0, 1.0);
    return hsv.withValue(newValue).toColor();
  }

  Color _createDarkColor() {
    final hsv = HSVColor.fromColor(this.baseColor).withAlpha(0.4);
    final newValue = (hsv.value - 0.2).clamp(0, 1.0);
    return hsv.withValue(newValue).toColor();
  }
}

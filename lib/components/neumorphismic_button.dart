import 'package:KRPG/components/animated_neumorphismic_container.dart';
import 'package:flutter/material.dart';

class NeumorphismicButton extends StatefulWidget {
  final bool? isActive;

  const NeumorphismicButton({Key? key, this.isActive}) : super(key: key);

  @override
  _NeumorphismicButtonState createState() => _NeumorphismicButtonState();
}

class _NeumorphismicButtonState extends State<NeumorphismicButton> {
  bool _isActive = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isActive = !_isActive;
        });
      },
      child: AnimatedNeumorphismicContainer(
        depth: _isActive ? 1.0 : 0.0,
        color: Color(0xFFF2F2F2),
        width: 60,
        height: 60,
        radius: 16,
        child: Icon(Icons.access_time),
      ),
    );
  }
}

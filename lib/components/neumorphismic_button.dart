import 'package:KRPG/components/animated_neumorphismic_container.dart';
import 'package:flutter/widgets.dart';

class NeumorphismicButton extends StatefulWidget {
  final bool isActive;

  const NeumorphismicButton({Key key, this.isActive}) : super(key: key);

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
        baseColor: Color(0xFFF2F2F2),
      ),
    );
  }
}

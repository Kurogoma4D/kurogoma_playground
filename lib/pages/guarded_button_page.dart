import 'package:flutter/material.dart';

class GuardedButtonPage extends StatelessWidget {
  const GuardedButtonPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _GuardedButton(
          buttonText: 'TAP ME',
          onTap: () async => await Future.delayed(Duration(seconds: 3)),
        ),
      ),
    );
  }
}

class SwitchableFlatButton extends StatelessWidget {
  const SwitchableFlatButton({
    Key key,
    this.buttonText,
    this.onTap,
    this.enabled,
  }) : super(key: key);

  final String buttonText;
  final VoidCallback onTap;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      color: Colors.greenAccent,
      textColor: Colors.black87,
      disabledColor: Colors.grey,
      disabledTextColor: Colors.white,
      child: Text(buttonText),
      onPressed: enabled ? onTap : null,
    );
  }
}

class _GuardedButton extends StatefulWidget {
  const _GuardedButton({Key key, this.buttonText, this.onTap})
      : super(key: key);

  final String buttonText;
  final Function onTap;

  @override
  __GuardedButtonState createState() => __GuardedButtonState();
}

class __GuardedButtonState extends State<_GuardedButton> {
  bool isActive = true;
  bool mounted = true;

  @override
  Widget build(BuildContext context) {
    return SwitchableFlatButton(
      buttonText: widget.buttonText,
      onTap: () async {
        setState(() => isActive = false);
        await widget.onTap();
        if (mounted) setState(() => isActive = true);
      },
      enabled: isActive,
    );
  }

  @override
  void dispose() {
    mounted = false;
    super.dispose();
  }
}

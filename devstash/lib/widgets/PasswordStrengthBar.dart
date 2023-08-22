import 'package:flutter/material.dart';

class PasswordStrengthBar extends StatelessWidget {
  late double strength;
  PasswordStrengthBar({Key? key, required this.strength}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color color;
    if (strength < 0.3) {
      color = Colors.red;
    } else if (strength < 0.7) {
      color = Colors.orange;
    } else {
      color = Colors.green;
    }
    return LinearProgressIndicator(
      value: strength,
      backgroundColor: Colors.grey[300],
      valueColor: AlwaysStoppedAnimation<Color>(color),
    );
  }
}

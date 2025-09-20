
import 'package:flutter/material.dart';

class BackgroundCircles extends StatelessWidget {
  const BackgroundCircles({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildCircle(Colors.greenAccent, top: -140, left: -30),
        _buildCircle(Colors.blue, top: -110, left: -60),
        _buildCircle(Colors.green, bottom: -200, right: -30),
        _buildCircle(Colors.lightGreen, bottom: -140, right: -80),
      ],
    );
  }

  Widget _buildCircle(Color color, {double? top, double? left, double? bottom, double? right}) {
    return Positioned(
      top: top,
      left: left,
      bottom: bottom,
      right: right,
      child: Container(
        width: 250,
        height: 250,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(200),
        ),
      ),
    );
  }
}

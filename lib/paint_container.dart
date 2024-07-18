import 'dart:math';

import 'package:flutter/material.dart';

class CustomContainer extends StatefulWidget {
  const CustomContainer({super.key});

  @override
  State<CustomContainer> createState() => _CustomContainerState();
}

class _CustomContainerState extends State<CustomContainer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("appbar"),
      ),
      body: Center(
        child: Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()..scale(-1.0, 1.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.brown.shade400,
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(12),
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12)),
            ),
            child: CustomPaint(
              size: const Size(200, 120),
              painter: CurvedPainter(),

            ),
          ),
        ),
      ),
    );
  }
}

class CurvedPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var center = const Offset(150.0, 120.0);
    var rectangle =
        Rect.fromCenter(center: center, width: 100.0, height: 90.0);
    var paint = Paint()..color = Colors.brown.shade400;
    canvas.drawArc(rectangle, 0.0, pi / 5, true, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

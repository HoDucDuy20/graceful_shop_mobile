import 'package:flutter/material.dart';
import 'package:graceful_shop/resources/utils/colors.dart';

class DrawTriangleShape extends CustomPainter {
  Paint painter = Paint()
    ..color = AppColors.mainColor
    ..style = PaintingStyle.fill;

  // DrawTriangleShape() {

  //   painter = Paint()
  //     ..color = Colors.purpleAccent
  //     ..style = PaintingStyle.fill;

  // }

  @override
  void paint(Canvas canvas, Size size) {
    var path = Path();

    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height * 1.5);
    path.close();

    canvas.drawPath(path, painter);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class DrawTriangleShape2 extends CustomPainter {
  Paint painter = Paint()
    ..color = AppColors.white3Color
    ..style = PaintingStyle.fill;

  // DrawTriangleShape() {

  //   painter = Paint()
  //     ..color = Colors.purpleAccent
  //     ..style = PaintingStyle.fill;

  // }

  @override
  void paint(Canvas canvas, Size size) {
    var path = Path();

    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height * 1.5);
    path.close();

    canvas.drawPath(path, painter);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

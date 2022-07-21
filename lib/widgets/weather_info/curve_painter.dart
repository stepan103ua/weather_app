import 'package:flutter/material.dart';
import 'package:weather_app/constants.dart';

class CurveLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();

    paint.color = Constants.containerBackgroundColor;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 3;

    var startPoint = Offset(0, size.height * 0.2);
    var controlPoint1 = Offset(size.width * 0.4, size.height * 0.1);
    var controlPoint2 = Offset(size.width * 0.6, size.height * 0.9);
    var endPoint = Offset(size.width, size.height * 0.8);

    var path = Path();
    path.moveTo(startPoint.dx, startPoint.dy);
    path.cubicTo(controlPoint1.dx, controlPoint1.dy, controlPoint2.dx,
        controlPoint2.dy, endPoint.dx, endPoint.dy);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

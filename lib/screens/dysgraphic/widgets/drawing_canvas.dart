import 'package:flutter/material.dart';
import 'package:app/screens/dysgraphic/controllers/drawing_controller.dart';

class DrawingCanvas extends StatefulWidget {
  final DrawingController controller;

  const DrawingCanvas({Key? key, required this.controller}) : super(key: key);

  @override
  _DrawingCanvasState createState() => _DrawingCanvasState();
}

class _DrawingCanvasState extends State<DrawingCanvas> {
  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      setState(() {});
    });
  }

  // Capture user drawing (pan gestures)
  void _onPanUpdate(DragUpdateDetails details) {
    widget.controller
        .draw(details.localPosition); // Ensure correct Offset extraction
  }

  // Complete the current path when the user lifts the finger
  void _onPanEnd(DragEndDetails details) {
    widget.controller.finishPath();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanUpdate: _onPanUpdate,
      onPanEnd: _onPanEnd,
      child: CustomPaint(
        painter: _DrawingPainter(widget.controller), // Pass controller only
        size: Size.infinite, // Expands to fit the available space
      ),
    );
  }
}

class _DrawingPainter extends CustomPainter {
  final DrawingController controller;

  _DrawingPainter(this.controller);

  @override
  void paint(Canvas canvas, Size size) {
    Paint userPaint = Paint()
      ..color = Colors.red
      ..strokeWidth = 4.0
      ..style = PaintingStyle.stroke;

    Paint guidingPaint = Paint()
      ..color = Colors.green.withOpacity(0.5)
      ..strokeWidth = 4.0
      ..style = PaintingStyle.stroke;

    // Draw user's completed paths
    for (var path in controller.userPaths) {
      if (path.isNotEmpty) {
        Path userPath = Path()..moveTo(path.first.dx, path.first.dy);
        for (var point in path) {
          userPath.lineTo(point.dx, point.dy);
        }
        canvas.drawPath(userPath, userPaint);
      }
    }

    // Draw the current ongoing path
    if (controller.currentPath.isNotEmpty) {
      Path userPath = Path()
        ..moveTo(
            controller.currentPath.first.dx, controller.currentPath.first.dy);
      for (var point in controller.currentPath) {
        userPath.lineTo(point.dx, point.dy);
      }
      canvas.drawPath(userPath, userPaint);
    }

    // Draw guiding animation path
    if (controller.isAnimationActive) {
      List<Offset>? guidingPath = controller.getGuidingPathForAnimation();
      if (guidingPath != null && guidingPath.isNotEmpty) {
        Path guidePath = Path()
          ..moveTo(guidingPath.first.dx, guidingPath.first.dy);
        for (var point in guidingPath) {
          guidePath.lineTo(point.dx, point.dy);
        }
        canvas.drawPath(guidePath, guidingPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true; // Repaint when notified
  }
}

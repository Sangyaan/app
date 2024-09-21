import 'package:app/screens/dysgraphic/controllers/drawing_controller_english_numbers.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrawingScreenEnglishNumbers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Drawing Screen'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer<DrawingControllerEnglishNumbers>(
              builder: (context, drawingController, child) {
                return GestureDetector(
                  onPanUpdate: (details) {
                    // Add point to the controller
                    RenderBox renderBox =
                        context.findRenderObject() as RenderBox;
                    Offset localPosition =
                        renderBox.globalToLocal(details.globalPosition);
                    drawingController.addPoint(localPosition);
                  },
                  onPanEnd: (details) {
                    drawingController.endStroke();
                  },
                  child: CustomPaint(
                    painter: _DrawingPainter(drawingController),
                    size: Size.infinite,
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Trigger the animation
                    context
                        .read<DrawingControllerEnglishNumbers>()
                        .animateLetter(Duration(milliseconds: 10));
                  },
                  child: Text('Animate Letter'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Trigger the animation
                    final drawingController =
                        Provider.of<DrawingControllerEnglishNumbers>(context,
                            listen: false);
                    drawingController.clearDrawing();
                  },
                  child: Text('Clear Drawing'),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Custom Painter to handle the drawing on the canvas
class _DrawingPainter extends CustomPainter {
  final DrawingControllerEnglishNumbers controller;

  _DrawingPainter(this.controller);

  @override
  void paint(Canvas canvas, Size size) {
    Paint greyPaint = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.square
      ..isAntiAlias = true
      ..strokeWidth = 10.0;

    Paint greenPaint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;

    Paint redPaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;

    // Draw the placeholder letter as animated (from animatedOffsets)
    if (controller.animatedOffsets.isNotEmpty) {
      for (int i = 0; i < controller.animatedOffsets.length - 1; i++) {
        if (controller.animatedOffsets[i] != null &&
            controller.animatedOffsets[i + 1] != null) {
          canvas.drawLine(
            controller.animatedOffsets[i],
            controller.animatedOffsets[i + 1],
            greyPaint,
          );
        }
      }
    }

    // Draw the user's drawing points
    if (controller.drawnPoints.isNotEmpty) {
      for (int i = 0; i < controller.drawnPoints.length - 1; i++) {
        if (controller.drawnPoints[i] != null &&
            controller.drawnPoints[i + 1] != null) {
          canvas.drawLine(
            controller.drawnPoints[i]!,
            controller.drawnPoints[i + 1]!,
            greenPaint,
          );
        }
      }
    }

    // Optionally, show similarity as a percentage
    final similarity = controller.calculateSimilarity();
    TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: 'Similarity: ${(similarity * 100).toStringAsFixed(2)}%',
        style: TextStyle(color: Colors.black, fontSize: 16),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset(10, 10));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

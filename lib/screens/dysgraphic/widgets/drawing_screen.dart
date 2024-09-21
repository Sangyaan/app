import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app/screens/dysgraphic/controllers/drawing_controller.dart';
import 'package:app/screens/dysgraphic/widgets/drawing_canvas.dart';

class DrawingScreen extends StatefulWidget {
  const DrawingScreen({Key? key}) : super(key: key);

  @override
  _DrawingScreenState createState() => _DrawingScreenState();
}

class _DrawingScreenState extends State<DrawingScreen> {
  @override
  Widget build(BuildContext context) {
    final DrawingController controller =
        Provider.of<DrawingController>(context, listen: false);

    return Scaffold(
      appBar: AppBar(title: Text("Drawing for Dysgraphia")),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                DrawingCanvas(controller: controller),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () => controller.resetDrawing(),
                  child: Text("Reset")),
              ElevatedButton(
                onPressed: () => controller.showGuidingAnimation(),
                child: Text("Show Animation"),
              ),
              ElevatedButton(
                onPressed: _submitDrawing,
                child: Text("Submit"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Logic for submitting and evaluating the drawing
  void _submitDrawing() {
    // Implement submission logic, check the drawn path with controller
    // If incorrect, show animation
  }
}

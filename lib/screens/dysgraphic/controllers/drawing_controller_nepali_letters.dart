import 'package:flutter/material.dart';
import 'dart:async';

class DrawingControllerNepaliLetters extends ChangeNotifier {
  // Store the user-drawn points
  List<Offset?> drawnPoints = [];

  // Placeholder for the letter 'b' as a list of Offset points
  List<Offset> letterOffsets;

  // Current points to animate
  List<Offset> animatedOffsets = [];

  // Flag to control if the letter is still animating
  bool isAnimating = true;

  DrawingControllerNepaliLetters(this.letterOffsets);

  // Method to add new points and notify listeners
  void addPoint(Offset point) {
    if (!isAnimating) {
      print(point);
      drawnPoints.add(point);
      notifyListeners();
    }
  }

  void addNextLetter(List<Offset> letterOffsets) {
    this.letterOffsets = letterOffsets;
  }

  // Method to stop strokes from connecting between them
  void endStroke() {
    drawnPoints.add(null); // Insert a null to break the stroke
    notifyListeners();
  }

  // Method to calculate similarity between drawn points and placeholder letter
  double calculateSimilarity() {
    int totalPoints = drawnPoints.where((p) => p != null).length;
    int greenPoints = drawnPoints
        .where((point) => point != null && isTouchingLetter(point))
        .length;

    if (totalPoints == 0) return 0.0;
    return greenPoints / totalPoints;
  }

  // Check if the drawn point is touching the placeholder letter
  bool isTouchingLetter(Offset point) {
    for (var offset in letterOffsets) {
      if ((point - offset).distance < 10.0) {
        // Allow small margin for touch detection
        return true;
      }
    }
    return false;
  }

  // Clear the drawn points
  void clearDrawing() {
    drawnPoints.clear();
    notifyListeners();
  }

  // Animate the placeholder by adding points to the animatedOffsets one by one
  Future<void> animateLetter(Duration duration) async {
    animatedOffsets.clear();
    isAnimating = true; // Disable drawing while animating

    for (var offset in letterOffsets) {
      await Future.delayed(duration);
      animatedOffsets.add(offset);
      notifyListeners();
    }

    isAnimating = false; // Enable drawing after animation completes
  }
}

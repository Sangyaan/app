import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class DrawingController extends ChangeNotifier {
  // Enum for writing types
  WritingType _selectedType = WritingType.englishLetters;

  List<List<Offset>> userPaths = []; // Multiple paths for each stroke
  List<Offset> currentPath = []; // Current stroke path

  // The currently selected character for drawing
  String _selectedCharacter = '';

  // Selected type and character
  WritingType get selectedType => _selectedType;
  String get selectedCharacter => _selectedCharacter;

  // Set the selected type of writing (English, Nepali, Numbers, etc.)
  void selectType(WritingType type) {
    _selectedType = type;
    notifyListeners();
  }

  void resetDrawing() {
    userPaths = [];
    currentPath = [];
    notifyListeners();
  }

  void draw(Offset point) {
    currentPath.add(point);
    notifyListeners();
  }

  void finishPath() {
    if (currentPath.isNotEmpty) {
      userPaths.add(currentPath);
      currentPath = [];
      notifyListeners();
    }
  }

  // Set the selected character
  void selectCharacter(String character) {
    _selectedCharacter = character;
    _isAnimationActive = true; // Reset the animation
    notifyListeners();
  }

  // Stroke paths for different writing types and characters
  final Map<String, List<Offset>> englishLettersPaths = {
    'A': [Offset(10, 10), Offset(50, 100), Offset(30, 60)], // Example
    'B': [Offset(20, 20), Offset(60, 100), Offset(40, 60)],
  };

  final Map<String, List<Offset>> nepaliLettersPaths = {
    'क': [Offset(10, 10), Offset(50, 50)], // Example for Nepali
    'ख': [Offset(20, 20), Offset(60, 60)],
  };

  final Map<String, List<Offset>> englishNumbersPaths = {
    '1': [Offset(10, 10), Offset(50, 100)], // Example for English numbers
  };

  final Map<String, List<Offset>> nepaliNumbersPaths = {
    '१': [Offset(10, 10), Offset(50, 100)], // Example for Nepali numbers
  };

  // Return path points based on the selected type and character
  List<Offset>? getPathForSelectedCharacter() {
    switch (_selectedType) {
      case WritingType.englishLetters:
        return englishLettersPaths[_selectedCharacter];
      case WritingType.nepaliLetters:
        return nepaliLettersPaths[_selectedCharacter];
      case WritingType.englishNumbers:
        return englishNumbersPaths[_selectedCharacter];
      case WritingType.nepaliNumbers:
        return nepaliNumbersPaths[_selectedCharacter];
    }
  }

  // Similarity threshold for checking correctness of the drawing
  final double _similarityThreshold = 0.85;

  // Function to check the similarity between the drawn path and the correct path
  bool checkSimilarity(List<List<Offset>> userPaths) {
    List<Offset>? correctPath = getPathForSelectedCharacter();
    if (correctPath == null) return false;

    // Perform the similarity check using a custom algorithm, e.g., dynamic time warping (DTW)
    return calculateSimilarity(
            userPaths.expand((e) => e).toList(), correctPath) >=
        _similarityThreshold;
  }

  // Placeholder similarity calculation method (implement your algorithm here)
  double calculateSimilarity(List<Offset> userPath, List<Offset> correctPath) {
    // Compare path points with a custom algorithm
    return 0.9; // Example: always return 90% similarity
  }

  // Animation control
  bool _isAnimationActive = false;
  bool get isAnimationActive => _isAnimationActive;
  int _currentAnimationStep = 0;

  // Function to trigger guiding animation for the selected character
  void showGuidingAnimation() {
    if (_selectedCharacter.isEmpty) return;
    _isAnimationActive = true;
    _currentAnimationStep = 0;
    notifyListeners();

    // Animation loop
    Future.doWhile(() async {
      if (_currentAnimationStep < getPathForSelectedCharacter()!.length) {
        await Future.delayed(Duration(milliseconds: 200));
        _currentAnimationStep++;
        notifyListeners();
        return true;
      } else {
        _isAnimationActive = false;
        notifyListeners();
        return false;
      }
    });
  }

  List<Offset>? getGuidingPathForAnimation() {
    List<Offset>? fullPath = getPathForSelectedCharacter();
    if (fullPath == null) return null;
    return fullPath.sublist(0, _currentAnimationStep);
  }
}

enum WritingType {
  nepaliLetters,
  englishLetters,
  englishNumbers,
  nepaliNumbers,
}

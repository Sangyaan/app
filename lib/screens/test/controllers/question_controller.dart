import 'dart:io';
import 'package:app/shared/contants/network.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class QuestionProvider with ChangeNotifier {
  int _currentQuestionIndex = 0;
  List<Question> _questions = []; // Change to List<Question>
  bool _isLoading = true;
  int _dyscalculicScore = 0;
  String _dysgraphicScore = "";
  bool _isCompleted = false;

  int get dyscalculicScore => _dyscalculicScore;
  String get dysgraphicScore => _dysgraphicScore;
  bool get isCompleted => _isCompleted;
  bool get isLoading => _isLoading;
  int get currentQuestionIndex => _currentQuestionIndex;
  Question? get currentQuestion =>
      _questions.isNotEmpty ? _questions[_currentQuestionIndex] : null;

  QuestionProvider() {
    fetchQuestionsFromApi(); // Fetch questions on initialization
  }

  void checkDiscalculiaAnswer(TextQuestion question, String answer) {
    if (answer == question.correct) {
      _dyscalculicScore++;
    }
  }

  Future<void> fetchQuestionsFromApi() async {
    try {
      _isLoading = true;
      notifyListeners();

      var response = await Dio().get('$server/getquestions');
      List<dynamic> data = response.data;

      // Parse response data into List<Question>
      _questions = data
          .map((item) =>
              TextQuestion(item['question'], item['options'], item['correct']))
          .cast<Question>() // Cast to List<Question>
          .toList();

      _questions.add(ImageQuestion(
              "Please capture or upload a photo of your handwritten notes.")
          as Question); // No need for as Question here; it's already a Question.

      // Reset the current question index to the first question
      _currentQuestionIndex = 0;
    } catch (error) {
      print('Error fetching questions: $error');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> uploadImageToBackend(File image) async {
    try {
      FormData formData = FormData.fromMap({
        "file":
            await MultipartFile.fromFile(image.path, filename: "upload.jpg"),
      });
      final response = await Dio().post("$server/upload", data: formData);
      print("Image uploaded successfully: ${response.data}");
      // Set a dummy score for illustration
      _dysgraphicScore = response.data["result"];
    } catch (e) {
      print("Error uploading image: $e");
    }
  }

  void nextQuestion(BuildContext context) {
    print(_questions.length);
    print(_currentQuestionIndex);
    print(_isCompleted);
    if (_currentQuestionIndex < _questions.length - 1) {
      _currentQuestionIndex++;
      notifyListeners(); // Notify listeners for UI updates
    } else if (!_isCompleted &&
        _currentQuestionIndex == _questions.length - 1) {
      _isCompleted = true;

      notifyListeners();
    }
  }
}

abstract class Question {}

class TextQuestion extends Question {
  final String questionText;
  final List<dynamic> options; // Assuming questions can have options
  final String correct;

  TextQuestion(this.questionText, this.options, this.correct);
}

class ImageQuestion extends Question {
  final String prompt;

  ImageQuestion(this.prompt);
}

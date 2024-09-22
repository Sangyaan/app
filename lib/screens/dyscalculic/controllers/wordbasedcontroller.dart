import 'package:app/shared/contants/network.dart';
import 'package:app/screens/dyscalculic/score_page.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class WordBasedProvider with ChangeNotifier {
  int _currentQuestionIndex = 0;
  List<DyscalculiaQuestion> _questions = [];
  bool _isLoading = true;
  int _dyscalculicScore = 0;
  bool _isCompleted = false;

  bool get isCompleted => _isCompleted;
  bool get isLoading => _isLoading;
  int get currentQuestionIndex => _currentQuestionIndex;
  DyscalculiaQuestion? get currentQuestion =>
      _questions.isNotEmpty ? _questions[_currentQuestionIndex] : null;

  WordBasedProvider() {
    fetchQuestionsFromApi(); // Fetch questions on initialization
  }

  Future<void> fetchQuestionsFromApi() async {
    try {
      _isLoading = true;
      notifyListeners();

      var response = await Dio().get('$server/WordBased');
      List<dynamic> data = response.data;

      // Parse response data into List<DyscalculiaQuestion>
      _questions = data
          .map((item) => DyscalculiaQuestion(item['question'], item['options'],
              item['correct'], item['explanation']))
          .toList();

      // Reset the current question index
      _currentQuestionIndex = 0;
    } catch (error) {
      print('Error fetching dyscalculia questions: $error');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void checkDiscalculiaAnswer(String selectedAnswer) {
    final current = currentQuestion;
    if (current != null && selectedAnswer == current.correct) {
      _dyscalculicScore++;
    }
  }

  void resetScore() {
    _dyscalculicScore = 0;
    notifyListeners();
  }

  void nextQuestion(BuildContext context) {
    if (_currentQuestionIndex < _questions.length - 1) {
      _currentQuestionIndex++;
      notifyListeners(); // Notify UI
    } else {
      _isCompleted = true;
      notifyListeners();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => ScorePage(
                score: _dyscalculicScore, totalQuestions: _questions.length)),
      );
    }
  }
}

class DyscalculiaQuestion {
  final String questionText;
  final List<dynamic> options;
  final String correct;
  final String explanation;

  DyscalculiaQuestion(
      this.questionText, this.options, this.correct, this.explanation);
}

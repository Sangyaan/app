import 'package:app/screens/dyscalculic/controllers/wordbasedcontroller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WordBasedQuiz extends StatefulWidget {
  @override
  _DyscalculiaQuizState createState() => _DyscalculiaQuizState();
}

class _DyscalculiaQuizState extends State<WordBasedQuiz> {
  bool _showExplanation = false;
  String? _selectedAnswer;
  bool _isAnswered = false;
  bool _isCorrect = false;

  @override
  Widget build(BuildContext context) {
    final questionProvider = Provider.of<WordBasedProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dyscalculia Quiz'),
      ),
      body: Center(
        child: questionProvider.isLoading
            ? const CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (questionProvider.currentQuestion != null)
                    _buildTextQuestion(
                        context, questionProvider.currentQuestion!),
                ],
              ),
      ),
    );
  }

  Widget _buildTextQuestion(
      BuildContext context, DyscalculiaQuestion question) {
    final questionProvider =
        Provider.of<WordBasedProvider>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            question.questionText,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          // Displaying all options
          ...question.options.map((option) {
            return ElevatedButton(
              onPressed: _isAnswered
                  ? null // Disable after an answer is selected
                  : () {
                      setState(() {
                        _selectedAnswer = option;
                        _isCorrect = option == question.correct;
                        _showExplanation =
                            !_isCorrect; // Show explanation if wrong
                        _isAnswered = true; // Mark the question as answered
                      });
                      questionProvider.checkDiscalculiaAnswer(option);
                    },
              style: ElevatedButton.styleFrom(
                // Colors for each option
                backgroundColor: _isAnswered
                    ? (option == question.correct
                        ? Colors.green // Correct answer is green
                        : option == _selectedAnswer
                            ? Colors.red // Selected wrong answer is red
                            : Colors.blue) // Unselected options remain blue
                    : Colors.blue, // Default color before answering
              ),
              child: Text(option),
            );
          }).toList(),
          const SizedBox(height: 20),
          // Display Correct or Wrong feedback
          if (_isAnswered)
            Text(
              _isCorrect ? 'Correct' : 'Wrong',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: _isCorrect ? Colors.green : Colors.red,
              ),
            ),
          const SizedBox(height: 20),
          if (_showExplanation) _buildExplanation(question),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _isAnswered
                ? () {
                    // Proceed to next question
                    setState(() {
                      _showExplanation = false;
                      _selectedAnswer = null;
                      _isAnswered = false;
                      _isCorrect = false;
                    });
                    questionProvider.nextQuestion(context);
                  }
                : null, // Disable button until an answer is selected
            child: const Text("Next"),
          ),
        ],
      ),
    );
  }

  Widget _buildExplanation(DyscalculiaQuestion question) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.yellow[100],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        children: [
          const Text(
            "Explanation",
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          const SizedBox(height: 8),
          Text(
            question.explanation,
            style: const TextStyle(fontSize: 16, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}

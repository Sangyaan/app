import 'package:app/screens/dyscalculic/controllers/wordbasedcontroller.dart';
import 'package:app/shared/contants/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WordBasedQuiz extends StatefulWidget {
  const WordBasedQuiz({super.key});

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
      backgroundColor: backgroundEel,
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Colors.transparent,
        title: const Text('Dyscalculia Quiz'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Center(
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(15)),
            child: Text(
              question.questionText,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                child: Divider(
                  color: textGrey,
                ),
                width: 40,
              ),
              Text(
                "Options",
                style: TextStyle(fontSize: 18, color: textGrey),
              ),
              SizedBox(
                child: Divider(
                  color: textGrey,
                ),
                width: 40,
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Displaying all options
          ...question.options.map((option) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: Container(
                width: MediaQuery.of(context).size.height * 0.3,
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                    color: pinkButtonShadow,
                    offset: Offset(0, 4),
                    blurRadius: 0,
                  )
                ], borderRadius: BorderRadius.circular(15)),
                child: ElevatedButton(
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
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    foregroundColor: Colors.white,
                    // Colors for each option
                    backgroundColor: _isAnswered
                        ? (option == question.correct
                            ? Colors.green // Correct answer is green
                            : option == _selectedAnswer
                                ? Colors.red // Selected wrong answer is red
                                : Colors
                                    .white) // Unselected options remain blue
                        : pinkButton, // Default color before answering
                  ),
                  child: Text(
                    option,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            );
          }),

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
          Container(
            width: MediaQuery.of(context).size.width * 0.5,
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(color: blueShadow, offset: Offset(0, 4), blurRadius: 0)
            ], borderRadius: BorderRadius.circular(15)),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: buttonBlue,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  padding: EdgeInsets.all(16)),
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
              child: const Text(
                "Next",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
            ),
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

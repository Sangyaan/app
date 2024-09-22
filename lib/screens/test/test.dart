import 'dart:async';
import 'dart:io'; // File handling for image
import 'package:app/shared/contants/colors.dart';
import 'package:app/screens/test/controllers/question_controller.dart';
import 'package:app/screens/test/widgets/answers_buttons.dart';
import 'package:app/shared/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // For image picking
import 'package:provider/provider.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  Timer? _timer;
  int _timeRemaining = 10;
  File? _selectedImage; // Store selected image

  @override
  void initState() {
    super.initState();
    // startTimer();
  }

  void startTimer() {
    _timer?.cancel();
    _timeRemaining = 10;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timeRemaining > 0) {
        setState(() {
          _timeRemaining--;
        });
      } else {
        _timer?.cancel();
        moveToNextQuestion();
      }
    });
  }

  void moveToNextQuestion() {
    _timer?.cancel();
    final questionProvider =
        Provider.of<QuestionProvider>(context, listen: false);
    questionProvider.nextQuestion(context);
    startTimer(); // Restart timer for next question
  }

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });

      // Send image to backend after selection
      final questionProvider =
          Provider.of<QuestionProvider>(context, listen: false);
      await questionProvider.uploadImageToBackend(_selectedImage!);
      // moveToNextQuestion(); // Move to next question after image upload
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final questionProvider = Provider.of<QuestionProvider>(context);
    return Scaffold(
      backgroundColor: backgroundEel,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          (questionProvider.currentQuestion != null &&
                  questionProvider.currentQuestion is TextQuestion)
              ? Text(
                  'Time: $_timeRemaining',
                  style: const TextStyle(fontSize: 18, color: Colors.white),
                )
              : const SizedBox(),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: questionProvider.isLoading
                ? const Column(
                    children: [
                      CircularProgressIndicator(),
                      Text(
                        "Preparing questions for the test!",
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (questionProvider.currentQuestion != null &&
                          questionProvider.currentQuestion is TextQuestion)
                        _buildTextQuestion(context,
                            questionProvider.currentQuestion as TextQuestion),
                      if (questionProvider.currentQuestion != null &&
                          questionProvider.currentQuestion is ImageQuestion)
                        _buildImageQuestion(context),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextQuestion(BuildContext context, TextQuestion question) {
    final questionProvider =
        Provider.of<QuestionProvider>(context, listen: false);
    startTimer();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25), color: Colors.white),
            child: Text(
              question.questionText,
              style: const TextStyle(fontSize: 24),
            ),
          ),
        ),
        ...question.options.map((option) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.65,
              child: BuildAnswerOption(option, () {
                questionProvider.checkDiscalculiaAnswer(question, option);
                moveToNextQuestion();
              }),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildImageQuestion(BuildContext context) {
    _timer?.cancel();

    return Column(
      children: [
        Column(children: [
          SizedBox(height: 145, child: Logo()),
          Image.asset('assets/images/question.png'),
          SizedBox(height: 20),
          Container(
            height: 300,
            width: 300,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text(
                  "Take Screening Test \nfor \Dysgraphia",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 150,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width * 0.6,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: blueShadow,
                                offset: Offset(0, 3), // Vertical offset
                                blurRadius: 0, // No blur effect
                              ),
                            ],
                            borderRadius: BorderRadius.circular(
                                15), // Match the button's border radius
                          ),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: buttonBlue,
                              foregroundColor: Colors.white,
                              elevation: 0, // Disable default elevation
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 12),
                            ),
                            onPressed: () {
                              _pickImage(ImageSource.camera);
                            },
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Icon(Icons.camera),
                                Text(
                                  'Capture  Note',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          )),
                      Container(
                          width: MediaQuery.of(context).size.width * 0.6,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: blueShadow,
                                offset: Offset(0, 3), // Vertical offset
                                blurRadius: 0, // No blur effect
                              ),
                            ],
                            borderRadius: BorderRadius.circular(
                                15), // Match the button's border radius
                          ),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: buttonBlue,
                              foregroundColor: Colors.white,
                              elevation: 0, // Disable default elevation
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 12),
                            ),
                            onPressed: () {
                              _pickImage(ImageSource.gallery);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const Icon(Icons.photo),
                                const Text(
                                  'Pick a photo',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          )),
                    ],
                  ),
                ),
              ],
            ),
          )
        ]),
        if (_selectedImage != null)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: Image.file(_selectedImage!)),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () =>
                      _confirmAndSendImage(), // Confirm & Send button
                  icon: const Icon(Icons.send),
                  label: const Text('Confirm & Send'),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Future<void> _confirmAndSendImage() async {
    final questionProvider =
        Provider.of<QuestionProvider>(context, listen: false);

    if (_selectedImage != null) {
      // Send image to backend
      await questionProvider.uploadImageToBackend(_selectedImage!);
      // questionProvider.nextQuestion(context);

      // After uploading, navigate to the score page
      Navigator.pushReplacementNamed(context, '/score');
    }
  }
}

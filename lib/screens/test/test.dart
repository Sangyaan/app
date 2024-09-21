import 'dart:async';
import 'dart:io'; // File handling for image
import 'package:app/screens/test/controllers/question_controller.dart';
import 'package:app/screens/test/widgets/answers_buttons.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // For image picking
import 'package:provider/provider.dart';

class TestPage extends StatefulWidget {
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
      appBar: AppBar(
        title: const Text('Discalculia Test'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: (questionProvider.currentQuestion != null &&
                    questionProvider.currentQuestion is TextQuestion)
                ? Text(
                    'Time: $_timeRemaining',
                    style: const TextStyle(fontSize: 18),
                  )
                : const SizedBox(),
          ),
        ],
      ),
      body: Center(
        child: questionProvider.isLoading
            ? const CircularProgressIndicator()
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
          child: Text(
            question.questionText,
            style: TextStyle(fontSize: 24),
          ),
        ),
        ...question.options.map((option) {
          return BuildAnswerOption(option, () {
            questionProvider.checkDiscalculiaAnswer(question, option);
            moveToNextQuestion();
          });
        }).toList(),
      ],
    );
  }

  Widget _buildImageQuestion(BuildContext context) {
    _timer?.cancel();

    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Please upload an image of your handwritten note',
            style: TextStyle(fontSize: 24),
          ),
        ),
        ElevatedButton.icon(
          onPressed: () => _pickImage(ImageSource.camera),
          icon: Icon(Icons.camera),
          label: Text('Capture Image'),
        ),
        ElevatedButton.icon(
          onPressed: () => _pickImage(ImageSource.gallery),
          icon: Icon(Icons.photo),
          label: Text('Select from Gallery'),
        ),
        if (_selectedImage != null)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: Image.file(_selectedImage!)),
                SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () =>
                      _confirmAndSendImage(), // Confirm & Send button
                  icon: Icon(Icons.send),
                  label: Text('Confirm & Send'),
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

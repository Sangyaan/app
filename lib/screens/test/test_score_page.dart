import 'package:app/screens/test/controllers/question_controller.dart';
import 'package:app/screens/test/widgets/image_button.dart';
import 'package:app/shared/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TestScorePage extends StatelessWidget {
  const TestScorePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<QuestionProvider>(builder: (context, value, child) {
      final dyslexic = ImageButton(
          imageUrl: "assets/images/dyslexic.png",
          text: "Dyslexic",
          isChecked: false,
          isRecommended: false);

      final dysgraphic = ImageButton(
        imageUrl: "assets/images/dysgraphic.png",
        text: "Dysgraphic",
        isChecked: false,
        isRecommended:
            value.dysgraphicScore.startsWith("Dysgraphic") ? true : false,
      );

      final dyscalculic = ImageButton(
        imageUrl: "assets/images/dyscalculic.png",
        text: "Dyscalculic",
        isChecked: false,
        isRecommended: value.dyscalculicScore < 3 ? true : false,
      );
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 150, child: Logo()),
              Text("Your Score for Dyscalculic: ${value.dyscalculicScore}"),
              Text("The photo you used: ${value.dysgraphicScore}"),
              Text("Please select one of the following: "),
              dyslexic,
              dysgraphic,
              dyscalculic,
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pinkAccent,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                onPressed: () async {
                  final SharedPreferences prefs =
                      await SharedPreferences.getInstance();

                  await prefs.setBool("dyslexic", dyslexic.isChecked);
                  await prefs.setBool("dysgraphic", dysgraphic.isChecked);
                  await prefs.setBool("dyscalculic", dyscalculic.isChecked);

                  if (dyslexic.isChecked ||
                      dyscalculic.isChecked ||
                      dysgraphic.isChecked) {
                    await prefs.setBool("takenTest", true);
                    Navigator.pushNamed(context, "/home");
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('You haven\'t selected anything'),
                      ),
                    );
                  }
                },
                child: const Text(
                  'Submit',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

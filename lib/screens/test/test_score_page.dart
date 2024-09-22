import 'package:app/contants/colors.dart';
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
    final questionProvider =
        Provider.of<QuestionProvider>(context, listen: false);

    final dyslexic = ImageButton(
      imageUrl: "assets/images/dyslexic.png",
      text: "Dyslexic",
      isChecked: false,
    );

    final dysgraphic = ImageButton(
      imageUrl: "assets/images/dysgraphic.png",
      text: "Dysgraphic",
      isChecked: false,
      isRecommended: (questionProvider.dysgraphicScore.startsWith("Dysgraphic")
          ? true
          : false),
    );

    final dyscalculic = ImageButton(
      imageUrl: "assets/images/dyscalculic.png",
      text: "Dyscalculic",
      isChecked: false,
      isRecommended: ((questionProvider.dyscalculicScore < 2) ? true : false),
    );

    return Scaffold(
        backgroundColor: backgroundEel,
        body: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            const SizedBox(height: 135, child: Logo()),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15), color: Colors.white),
              child: const Text(
                'According to the screening test',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 100,
                  child: Divider(
                    thickness: 1,
                    color: textGrey,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    'Available Learning Path',
                    style: TextStyle(color: textGrey),
                  ),
                ),
                SizedBox(
                  width: 100,
                  child: Divider(
                    thickness: 1,
                    color: textGrey,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            dysgraphic,
            const SizedBox(
              height: 50,
            ),
            dyscalculic,
            const SizedBox(
              height: 75,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.6,
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    color: blueShadow,
                    offset: const Offset(0, 4),
                    blurRadius: 0)
              ], borderRadius: BorderRadius.circular(15)),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: buttonBlue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                onPressed: () async {
                  final SharedPreferences prefs =
                      await SharedPreferences.getInstance();

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
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}

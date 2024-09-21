import 'package:app/screens/test/widgets/image_button.dart';
import 'package:app/shared/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TakeTestPage extends StatelessWidget {
  const TakeTestPage({super.key});

  @override
  Widget build(BuildContext context) {
    final dyslexic = ImageButton(
      imageUrl: "assets/images/dyslexic.png",
      text: "Dyslexic",
      isChecked: false,
    );

    final dysgraphic = ImageButton(
      imageUrl: "assets/images/dysgraphic.png",
      text: "Dysgraphic",
      isChecked: false,
    );

    final dyscalculic = ImageButton(
      imageUrl: "assets/images/dyscalculic.png",
      text: "Dyscalculic",
      isChecked: false,
    );
    // final dysgraphic = ImageButton(imageUrl: imageUrl, text: text)

    return Scaffold(
        body: Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.05,
        ),
        const SizedBox(height: 150, child: Logo()),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
          onPressed: () {
            Navigator.pushNamed(context, "/test");
          },
          child: const Text(
            'Take Test',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 100,
              child: Divider(
                thickness: 1,
                color: Colors.black,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Text('Already Know Yourself'),
            ),
            SizedBox(
              width: 100,
              child: Divider(
                thickness: 1,
                color: Colors.black,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
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
    ));
  }
}

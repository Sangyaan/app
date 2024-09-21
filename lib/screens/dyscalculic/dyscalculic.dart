import 'package:app/screens/dyscalculic/widgets/options_button.dart';
import 'package:app/shared/widgets/logo.dart';
import 'package:flutter/material.dart';

class DyscalculicPage extends StatelessWidget {
  const DyscalculicPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
        ),
        body: const Column(
          children: [
            SizedBox(height: 150, child: Logo()),
            Text(
              "Dyscalculic",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(height: 30),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  OptionsButton(
                      imageUrl: "assets/images/words.png",
                      title: "Word Based Quiz",
                      route: "/wordbased"),
                  OptionsButton(
                      imageUrl: "assets/images/numbers.png",
                      title: "Number Based Quiz",
                      route: "/numberbased"),
                  OptionsButton(
                      imageUrl: "assets/images/maths_game.png",
                      title: "Maths Game",
                      route: "/mainMenu"),
                ],
              ),
            )
          ],
        ));
  }
}

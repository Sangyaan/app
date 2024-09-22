import 'package:app/contants/colors.dart';
import 'package:app/screens/dyscalculic/widgets/options_button.dart';
import 'package:app/shared/widgets/logo.dart';
import 'package:flutter/material.dart';

class DyscalculicPage extends StatelessWidget {
  const DyscalculicPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundEel,
        appBar: AppBar(
          toolbarHeight: 0,
          backgroundColor: Colors.transparent,
        ),
        body: Column(
          children: [
            SizedBox(height: 150, child: Logo()),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                    width: 40,
                    child: Divider(
                      color: textGrey,
                    )),
                Text(
                  "Improve your mathematics through",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: textGrey),
                ),
                SizedBox(
                    width: 40,
                    child: Divider(
                      color: textGrey,
                    )),
              ],
            ),
            const SizedBox(height: 30),
            const Expanded(
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

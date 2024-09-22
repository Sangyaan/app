import 'package:app/contants/colors.dart';
import 'package:app/screens/dyscalculic/widgets/options_button.dart';
import 'package:app/shared/widgets/logo.dart';
import 'package:flutter/material.dart';

class DysgraphicPage extends StatelessWidget {
  const DysgraphicPage({super.key});

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
          const SizedBox(
            height: 150,
            child: Logo(),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                          width: 40,
                          child: Divider(
                            color: textGrey,
                          )),
                      Text(
                        "Improve your writing for",
                        style: TextStyle(color: textGrey, fontSize: 16),
                      ),
                      SizedBox(
                          width: 40,
                          child: Divider(
                            color: textGrey,
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  OptionsButton(
                    imageUrl: "assets/images/nepali_letters.png",
                    title: "Nepali Letters",
                    route: "/drawing_screen_nepali_letters",
                  ),
                  SizedBox(height: 20),
                  OptionsButton(
                    imageUrl: "assets/images/english_alphabets.png",
                    title: "English Alphabets",
                    route: "/drawing_screen_english_alphabets",
                  ),
                  SizedBox(height: 20),
                  OptionsButton(
                    imageUrl: "assets/images/nepali_numbers.png",
                    title: "Nepali Nunbers",
                    route: "/drawing_screen_nepali_numbers",
                  ),
                  SizedBox(height: 20),
                  OptionsButton(
                    imageUrl: "assets/images/english_numbers.png",
                    title: "English Numbers",
                    route: "/drawing_screen_english_numbers",
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:app/screens/dyscalculic/widgets/options_button.dart';
import 'package:app/shared/widgets/logo.dart';
import 'package:flutter/material.dart';

class DysgraphicPage extends StatelessWidget {
  const DysgraphicPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: const Column(
        children: [
          SizedBox(
            height: 150,
            child: Logo(),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
              child: Column(
                children: [
                  OptionsButton(
                    imageUrl: "assets/images/nepali_letters.png",
                    title: "Draw Nepali Letters",
                    route: "/drawing_screen",
                  ),
                  SizedBox(height: 20),
                  OptionsButton(
                    imageUrl: "assets/images/english_alphabets.png",
                    title: "Draw Nepali Letters",
                    route: "/drawing_screen",
                  ),
                  SizedBox(height: 20),
                  OptionsButton(
                    imageUrl: "assets/images/nepali_numbers.png",
                    title: "Draw Nepali Letters",
                    route: "/drawing_screen",
                  ),
                  SizedBox(height: 20),
                  OptionsButton(
                    imageUrl: "assets/images/english_numbers.png",
                    title: "Draw Nepali Letters",
                    route: "/drawing_screen",
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

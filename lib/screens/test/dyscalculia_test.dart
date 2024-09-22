import 'package:app/shared/contants/colors.dart';
import 'package:app/shared/widgets/logo.dart';
import 'package:flutter/material.dart';

class TakeDyslexiaTest extends StatelessWidget {
  const TakeDyslexiaTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: backgroundEel,
      body: Column(children: [
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
              Text(
                "Take Screening Test \nfor \nDyscalculia",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.5,
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
                    Navigator.pushNamed(context, "/test");
                  },
                  child: const Text(
                    'Start',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ]),
    );
  }
}

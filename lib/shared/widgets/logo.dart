import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 100,
            width: 100,
            child: Image.asset(
              "assets/images/logo.png",
              height: 20,
            ),
          ),
          // const Text(
          //   "संज्ञान",
          //   style: TextStyle(
          //       fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),
          // ),
        ],
      ),
    );
  }
}

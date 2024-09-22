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
            height: 75,
            width: 100,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/logo.png",
                  height: 50,
                ),
                const Text(
                  "संज्ञान",
                  style: TextStyle(color: Colors.green, fontSize: 20),
                )
              ],
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

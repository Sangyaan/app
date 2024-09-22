import 'package:app/shared/contants/colors.dart';
import 'package:flutter/material.dart';

class OptionsButton extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String route;
  const OptionsButton(
      {super.key,
      required this.imageUrl,
      required this.title,
      required this.route});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: featherGreen,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: shadowGreen,
            spreadRadius: 0,
            blurRadius: 0,
            offset: const Offset(0, 7),
          ),
        ],
      ),
      height: 150,
      width: MediaQuery.of(context).size.width * 0.85,
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, route),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset(imageUrl),
            Text(
              title,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}

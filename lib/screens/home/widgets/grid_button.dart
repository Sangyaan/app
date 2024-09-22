import 'package:app/contants/colors.dart';
import 'package:flutter/material.dart';

class GridButton extends StatelessWidget {
  final String imageUrl;
  final String text;
  final String route;
  const GridButton(
      {super.key,
      required this.imageUrl,
      required this.text,
      required this.route});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.2,
      width: MediaQuery.of(context).size.width * 0.34,
      decoration: BoxDecoration(
        color: featherGreen,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: shadowGreen,
            spreadRadius: 0,
            blurRadius: 0,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, route),
        child: Column(
          children: [
            Image.asset(imageUrl),
            Text(
              text,
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}

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
      width: MediaQuery.of(context).size.width * 0.25,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, route),
        child: Column(
          children: [Image.asset(imageUrl), Text(text)],
        ),
      ),
    );
  }
}

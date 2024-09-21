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
        color: Colors.lightBlueAccent,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      height: 150,
      width: MediaQuery.of(context).size.width * 0.85,
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, route),
        child: Row(
          children: [
            Image.asset(imageUrl),
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            )
          ],
        ),
      ),
    );
  }
}

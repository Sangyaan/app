import 'package:flutter/material.dart';

Widget BuildAnswerOption(String option, VoidCallback onTap) {
  return SizedBox(
    width: 300,
    child: GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
        margin: EdgeInsets.symmetric(vertical: 8), // Adds space between options
        decoration: BoxDecoration(
          color: Color(0xFFFF9051), // Background color
          borderRadius: BorderRadius.circular(30), // Circular border rectangle
          border: Border.all(
            color: Colors.black, // Border color
            width: 2, // Border width
          ),
        ),
        child: Center(
          child: Text(
            option,
            style: const TextStyle(
              fontWeight: FontWeight.bold, // Bold text
              color: Colors.white, // Text color
              fontSize: 18, // Font size for better readability
            ),
          ),
        ),
      ),
    ),
  );
}

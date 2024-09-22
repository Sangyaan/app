import 'package:app/shared/contants/colors.dart';
import 'package:flutter/material.dart';

Widget BuildAnswerOption(String option, VoidCallback onTap) {
  return Container(
    height: 50,
    decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: pinkButtonShadow,
          offset: Offset(0, 3), // Vertical offset
          blurRadius: 0, // No blur effect
        ),
      ],
      borderRadius:
          BorderRadius.circular(15), // Match the button's border radius
    ),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: pinkButton,
        foregroundColor: Colors.white,
        elevation: 0, // Disable default elevation
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
      onPressed: () {
        onTap();
      },
      child: Text(
        option,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}

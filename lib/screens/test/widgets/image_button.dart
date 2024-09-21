import 'package:app/screens/test/controllers/checkbox_controller.dart';
import 'package:flutter/material.dart';

class ImageButton extends StatefulWidget {
  final String imageUrl;
  final String text;
  bool isChecked;
  bool isRecommended;

  ImageButton(
      {required this.imageUrl,
      required this.text,
      this.isChecked = false,
      this.isRecommended = false});

  @override
  State<ImageButton> createState() => _ImageButtonState();
}

class _ImageButtonState extends State<ImageButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          widget.imageUrl,
          width: 150,
          height: 150,
          fit: BoxFit.cover,
        ),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            children: [
              Text(
                widget.text,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              widget.isRecommended
                  ? const Text("Recommended",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.green))
                  : const SizedBox(),
            ],
          ),
        ),
        Checkbox(
          value: widget.isChecked,
          onChanged: (value) {
            setState(() {
              widget.isChecked = widget.isChecked ? false : true;
            });
          },
        ),
      ],
    );
  }
}

import 'package:app/contants/colors.dart';
import 'package:flutter/material.dart';

class ImageButton extends StatefulWidget {
  final String imageUrl;
  final String text;
  bool isChecked;
  bool isRecommended;

  ImageButton(
      {super.key,
      required this.imageUrl,
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
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(boxShadow: [
                  BoxShadow(
                      color: shadowGreen, offset: Offset(0, 3), blurRadius: 0)
                ], borderRadius: BorderRadius.circular(15)),
                width: MediaQuery.of(context).size.width * 0.7,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shadowColor: shadowGreen,
                    backgroundColor: featherGreen,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                  ),
                  onPressed: () {
                    setState(() {
                      widget.isChecked = widget.isChecked ? false : true;
                    });
                  },
                  child: Text(
                    widget.text,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
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
          checkColor: Colors.white,
          fillColor: const WidgetStatePropertyAll(Colors.transparent),
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

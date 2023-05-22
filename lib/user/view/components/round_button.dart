import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  String text;
  Color color;
  VoidCallback onTap;
  Color textColor;
  RoundButton({
    Key? key,
    required this.text,
    required this.color,
    required this.textColor,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 45.0,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: color,
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontFamily: "Product Sans",
              color: textColor,
              fontSize: 15.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

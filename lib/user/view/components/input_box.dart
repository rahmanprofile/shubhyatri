import 'package:flutter/material.dart';

class InputBox extends StatelessWidget {
  final String text;
  final IconData prefixIcon;
  final TextEditingController controller;
  final VoidCallback onTap;
  final bool isHide;
  final TextInputType textInputType;

  const InputBox({
    Key? key,
    required this.text,
    required this.prefixIcon,
    required this.controller,
    required this.isHide,
    required this.onTap,
    required this.textInputType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Center(
          child: TextFormField(
            controller: controller,
            keyboardType: textInputType,
            obscureText: isHide,
            style: const TextStyle(
                fontFamily: "Product Sans",
                fontSize: 17,
                fontWeight: FontWeight.w400),
            decoration: InputDecoration(
              hintText: text,
              border: InputBorder.none,
              hintStyle: const TextStyle(
                  fontFamily: "Product Sans",
                  fontSize: 17,
                  fontWeight: FontWeight.w400),
              prefixIcon: Icon(
                prefixIcon,
                size: 20,
                color: Colors.red,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

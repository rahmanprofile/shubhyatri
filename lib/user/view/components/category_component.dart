import 'package:flutter/material.dart';

class CategoryComponentButton<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final String text;
  final ValueChanged<T?> onChanged;
  const CategoryComponentButton({
    Key? key,
    required this.value,
    required this.groupValue,
    required this.text,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged(value),
      child: Row(
        children: [
          _customRadioButton(),
        ],
      ),
    );
  }

  Widget _customRadioButton() {
    final isSelected = value == groupValue;
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.0),
          border: Border.all(color: Colors.black12, width: 1.5),
          color: isSelected ? const Color(0xFF0071FF) : Colors.white,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontFamily: "Product Sans",
            fontWeight: FontWeight.w400,
            color: isSelected ? Colors.white : Colors.black54,
          ),
        ),
      ),
    );
  }
}

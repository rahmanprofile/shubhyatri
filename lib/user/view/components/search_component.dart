import 'package:flutter/material.dart';

import '../../controller/contant.dart';

class SearchComponent extends StatelessWidget {
  String text;
  IconData icon;
  TextEditingController controller;
  VoidCallback onTap;
  //VoidCallback onChanged;
  SearchComponent({
    Key? key,
    required this.text,
    required this.icon,
    required this.controller,
    required this.onTap,
    // required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45.0,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: Colors.grey[200],
      ),
      child: TextFormField(
        //onChanged: onChanged,
        controller: controller,
        decoration: InputDecoration(
          hintStyle: styleWhite14,
          prefixIcon: Icon(icon, size: 18),
          hintText: text,
          border: InputBorder.none,
        ),
      ),
    );
  }
}

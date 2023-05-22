import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastMessage {
  static void show(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}

class NavigatorPage {
  static void to(context, Widget widgetName) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => widgetName));
  }

  static void until(context, Widget widgetName) {
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => widgetName), (route) => false);
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shubhyatri/user/controller/contant.dart';

class DriverHomePage extends StatefulWidget {
  const DriverHomePage({Key? key}) : super(key: key);

  @override
  State<DriverHomePage> createState() => _DriverHomePageState();
}

class _DriverHomePageState extends State<DriverHomePage> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Driver"),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
        iconSize: 22.0,
        selectedLabelStyle: styleBlack13,
        //unselectedFontSize: styleBlack14,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.app_badge_fill), label: "Directory"),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.money_dollar), label: "Money"),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.staroflife_fill), label: "Rating"),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.person_fill), label: "Profile"),
        ],
      ),
    );
  }
}

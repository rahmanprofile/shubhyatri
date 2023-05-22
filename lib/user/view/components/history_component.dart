import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../controller/contant.dart';

class HistoryComponent extends StatelessWidget {
  String origin;
  String destination;
  String time;
  HistoryComponent({
    Key? key,
    required this.time,
    required this.origin,
    required this.destination,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text("Time : $time"),
      leading: Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5.0)),
        child: const Center(
          child: Icon(CupertinoIcons.arrow_2_squarepath),
        ),
      ),
      subtitle: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text("Origin : $origin", style: styleBlackNormal13),
        Text("Destination : $destination", style: styleBlackNormal13),
      ]),
    );
  }
}

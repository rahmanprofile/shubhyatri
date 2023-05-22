import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../controller/contant.dart';
import '../components/history_component.dart';

class TravelHistory extends StatefulWidget {
  const TravelHistory({Key? key}) : super(key: key);

  @override
  State<TravelHistory> createState() => _TravelHistoryState();
}

class _TravelHistoryState extends State<TravelHistory> {
  final auth = FirebaseAuth.instance.currentUser;
  final system = SystemUiOverlayStyle(statusBarColor: Colors.blue[700]);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(system);
    return Scaffold(
      appBar: AppBar(
        title: Text("Travel History", style: styleWhite20),
      ),
      body: FutureBuilder(
        future: FirebaseFirestore.instance.collection("users").doc(auth!.uid).collection("history").get(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if(!snapshot.hasData) {
            return Center(
              child: Text("No data found...",style: styleBlack16),
            );
          } else {
            return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data!.length,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return HistoryComponent(
                      time: snapshot.data[index]!.time.toString(),
                      origin: snapshot.data[index]!.origin.toString(),
                      destination: snapshot.data[index]!.destination.toString(),
                  );
                });
          }
        },

      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controller/contant.dart';
import '../components/input_box.dart';
import '../components/round_button.dart';

class ServicePage extends StatefulWidget {
  const ServicePage({Key? key}) : super(key: key);

  @override
  State<ServicePage> createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final aadhaarController = TextEditingController();
  bool isLoading = false;
  final store = FirebaseFirestore.instance;
  final currentUser = FirebaseAuth.instance.currentUser;
  void updateUserServices() async {
    setState(() {
      isLoading = true;
    });
    await store.collection("users").doc(currentUser!.uid).collection("services").add({
      "name": nameController.text,
      "phone": phoneController.text,
      "aadhaar": aadhaarController.text,
      "terms-free": "You are agree with our free terms",
      "conditions-free": "You are are agree with our free conditions",
      "apply-time": DateTime.now(),
      "uid": currentUser!.uid,
    }).then((value) => {
      Navigator.pop(context),
      setState(() {
        isLoading = false;
      }),
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text("My Service"),
      ),
      body: Padding(
        padding:const EdgeInsets.symmetric(horizontal: 20,vertical: 60),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("ShubhYatri \nFree Points?",style: GoogleFonts.roboto(fontSize: 35,fontWeight: FontWeight.w500),),
            const SizedBox(height: 8.0),
            Text("APPLY NOW YOUR \nFREE POINTS TO USE FREE RIDES",style: GoogleFonts.roboto(fontSize: 19,fontWeight: FontWeight.w500,color: Colors.red.shade300)),
            const SizedBox(height: 15),
            InputBox(
                text: "Name",
                prefixIcon: CupertinoIcons.person_fill,
                controller: nameController,
                isHide: false,
                onTap: (){},
                textInputType: TextInputType.text
            ),
            const SizedBox(height: 10),
            InputBox(
                text: "Phone",
                prefixIcon: CupertinoIcons.phone_fill,
                controller: phoneController,
                isHide: false,
                onTap: (){},
                textInputType: TextInputType.text
            ),
            const SizedBox(height: 10),
            InputBox(
                text: "Aadhaar",
                prefixIcon: CupertinoIcons.creditcard_fill,
                controller: aadhaarController,
                isHide: false,
                onTap: (){},
                textInputType: TextInputType.text
            ),
            const SizedBox(height: 20),
            RoundButton(
                text: "Confirmation",
                color: Colors.red,
                textColor: Colors.white,
                onTap: () async {
              setState(() {
                updateUserServices();
                isLoading = true;
              });
            }),
            const SizedBox(height: 10),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("After confirmation the free riding service will be expired",style: styleBlackNormal13),
                  Text("within two weeks so enjoy your free ride after confirmation.",style: styleBlackNormal13),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

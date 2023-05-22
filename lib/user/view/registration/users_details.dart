import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../controller/contant.dart';
import '../../controller/toast_message.dart';
import '../components/input_box.dart';
import '../home.dart';

class UsersDetails extends StatefulWidget {
  const UsersDetails({Key? key}) : super(key: key);

  @override
  State<UsersDetails> createState() => _UsersDetailsState();
}

class _UsersDetailsState extends State<UsersDetails> {
  bool isLoading = false;
  final aboutController = TextEditingController();
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final phoneController = TextEditingController();
  final store = FirebaseFirestore.instance;
  final currentUser = FirebaseAuth.instance.currentUser;
  void getUserDetails() async {
    setState(() {
      isLoading = true;
    });
    await store.collection("users").doc(currentUser!.uid).set({
      "name": nameController.text,
      "phone": phoneController.text,
      "age": ageController.text,
      "about": aboutController.text,
      "terms": "${nameController.text} are agree with our terms",
      "conditions": "${nameController.text} are agree with our conditions",
      "creation": DateTime.now(),
      "uid": currentUser!.uid,
    }).then((value) => {
          NavigatorPage.until(context, const Home()),
          setState(() {
            isLoading = false;
          }),
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Users some \nare details required?", style: styleBlack35),
            const SizedBox(height: 20),
            const Text(
                "Enter your correct details. We'll verify after registration. \nso make sure your details are correct?"),
            const SizedBox(height: 20),
            InputBox(
              text: "Nice name",
              prefixIcon: CupertinoIcons.person_fill,
              controller: nameController,
              isHide: false,
              onTap: () {},
              textInputType: TextInputType.text,
            ),
            const SizedBox(height: 10.0),
            InputBox(
              text: "Phone number",
              prefixIcon: CupertinoIcons.phone_fill,
              controller: phoneController,
              isHide: false,
              onTap: () {},
              textInputType: TextInputType.text,
            ),
            const SizedBox(height: 10.0),
            InputBox(
              text: "Current age",
              prefixIcon: CupertinoIcons.graph_square_fill,
              controller: ageController,
              isHide: false,
              onTap: () {},
              textInputType: TextInputType.text,
            ),
            const SizedBox(height: 10.0),
            InputBox(
              text: "Your bio",
              prefixIcon: CupertinoIcons.paperplane_fill,
              controller: aboutController,
              isHide: false,
              onTap: () {},
              textInputType: TextInputType.text,
            ),
            const SizedBox(height: 20),
            isLoading
                ? const Center(
                    child: CircularProgressIndicator(color: Colors.red),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () async {
                          setState(() {
                            getUserDetails();
                            isLoading = true;
                          });
                        },
                        child: Container(
                          height: 45,
                          width: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            color: Colors.red,
                          ),
                          child: const Center(
                            child: Text(
                              "Next",
                              style: TextStyle(
                                fontFamily: "Product Sans",
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}

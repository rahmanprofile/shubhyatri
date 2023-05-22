import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controller/contant.dart';
import '../../controller/toast_message.dart';
import '../components/round_button.dart';
import 'get_verify.dart';

class PhoneAuth extends StatefulWidget {
  const PhoneAuth({Key? key}) : super(key: key);

  @override
  State<PhoneAuth> createState() => _PhoneAuthState();
}

class _PhoneAuthState extends State<PhoneAuth> {
  final auth = FirebaseAuth.instance;
  final phoneController = TextEditingController();
  bool isLoading = false;
  final String code = '+91';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("What is your \nphone number?",
                style: GoogleFonts.roboto(
                    fontSize: 35.0, fontWeight: FontWeight.bold)),
            //Image.asset("assets/img/log.png",height: 150,width: 150),
            const SizedBox(height: 30),
            Text(
                "Tap 'Continue' to get an sms for confirmation to help \n you to use our services. We would like your number.",
                style: styleBlackNormal13),
            const SizedBox(height: 20),
            Container(
              height: 45,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                  color: Colors.grey[200]),
              child: TextFormField(
                controller: phoneController,
                onChanged: (value) {
                  setState(() {});
                },
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                    hintText: "Enter phone number",
                    border: InputBorder.none,
                    prefixIcon: Icon(CupertinoIcons.phone, size: 20)),
              ),
            ),
            const SizedBox(height: 20),
            isLoading
                ? const Center(
                    child: CircularProgressIndicator(color: Colors.red),
                  )
                : RoundButton(
                    text: "Continue",
                    color: Colors.red,
                    textColor: Colors.white,
                    onTap: () async {
                      setState(() {
                        isLoading = true;
                      });
                      await auth.verifyPhoneNumber(phoneNumber:phoneController.text,
                        verificationCompleted: (PhoneAuthCredential credential) {
                          setState(() {
                            isLoading = false;
                          });
                        },
                        verificationFailed: (FirebaseAuthException exception) {
                          setState(() {
                            isLoading = false;
                          });
                        },
                        codeSent: (String verificationId, int? token) {
                          NavigatorPage.to(context, GetVerify(
                              verificationId: verificationId,
                              phoneNumber: phoneController.text.trim()),
                          );
                          setState(() {
                            isLoading = false;
                          });
                        },
                        codeAutoRetrievalTimeout: (String verificationId) {
                        debugPrint("Time Update => ${verificationId.toString()}");
                        setState(() {
                          isLoading = false;
                        });
                        },
                      );
                    },
                  ),
          ],
        ),
      ),
    );
  }
}

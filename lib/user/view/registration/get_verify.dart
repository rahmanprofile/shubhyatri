import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:shubhyatri/user/view/registration/users_details.dart';

import '../../controller/contant.dart';
import '../../controller/toast_message.dart';
import '../components/round_button.dart';

class GetVerify extends StatefulWidget {
  final String verificationId;
  final String phoneNumber;
  const GetVerify({
    Key? key,
    required this.verificationId,
    required this.phoneNumber,
  }) : super(key: key);

  @override
  State<GetVerify> createState() => _GetVerifyState();
}

class _GetVerifyState extends State<GetVerify> {
  final auth = FirebaseAuth.instance;
  final _phoneNumberController = TextEditingController();
   bool isLoading = false;
  //bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Verify phone \nnumber?", style: styleBlack35),
            const SizedBox(height: 20.0),
            Text(
                "Check your SMS message. We've send you \nthe pin at +91 ${widget.phoneNumber}",
                style: styleBlack15),
            const SizedBox(height: 15.0),
            Pinput(
              length: 6,
              controller: _phoneNumberController,
              androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsRetrieverApi,
              defaultPinTheme: PinTheme(
                width: 56,
                height: 56,
                textStyle: const TextStyle(
                    fontSize: 20,
                    color: Color.fromRGBO(30, 60, 87, 1),
                    fontWeight: FontWeight.w600),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black54),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            GestureDetector(
              onTap: () {},
              child: Row(
                children: [
                  Text("Didn't recieve SMS? ", style: styleBlack15),
                  Text(
                    "Resend Code.",
                    style: GoogleFonts.roboto(
                      color: Colors.red,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25.0),
            isLoading
                ? const Center(
                    child: CircularProgressIndicator(color: Colors.red),
                  )
                : RoundButton(
                    text: "Confirm",
                    color: Colors.red,
                    textColor: Colors.white,
                    onTap: () async {
                      setState(() {
                        isLoading = true;
                      });
                      PhoneAuthCredential credential =
                          PhoneAuthProvider.credential(
                        verificationId: widget.verificationId,
                        smsCode: _phoneNumberController.text,
                      );
                      await auth.signInWithCredential(credential).then(
                          (value) => NavigatorPage.until(
                              context, const UsersDetails(),),
                      );
                      setState(() {
                        isLoading = false;
                      });
                    },
                  ),
            const SizedBox(height: 25.0),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Text("After confirmation you agree our all types of terms"),
                  Text("policy and conditions & include service charges."),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // void codeVerify() async {
  //   final credential = PhoneAuthProvider.credential(
  //     verificationId: widget.verificationId,
  //     smsCode: _phoneNumberController.text,
  //   );

  // try {
  //   setState(() {
  //     loading = true;
  //   });
  //   await FirebaseAuth.instance
  //       .signInWithCredential(credential)
  //       .then((value) {
  //     Navigator.pushAndRemoveUntil(
  //         context,
  //         MaterialPageRoute(builder: (context) => const CompleteProfile()),
  //             (route) => false);
  //     setState(() {
  //       loading = false;
  //     });
  //   });
  // }  catch (exp) {
  //   setState(() {
  //     loading = false;
  //   });
  // }
}

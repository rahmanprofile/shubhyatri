import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shubhyatri/user/view/registration/phone_auth.dart';

import '../../controller/contant.dart';
import '../../controller/toast_message.dart';
import '../components/round_button.dart';

class UsersRouterPage extends StatefulWidget {
  const UsersRouterPage({Key? key}) : super(key: key);

  @override
  State<UsersRouterPage> createState() => _UsersRouterPageState();
}

class _UsersRouterPageState extends State<UsersRouterPage> {
  final bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(0.0),
          image: const DecorationImage(
            fit: BoxFit.contain,
            image: AssetImage("assets/img/main.jpg"),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "ShubhYatri",
                style: GoogleFonts.raleway(
                    color: Colors.red,
                    fontSize: 30,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                "MostWelcome You",
                style: GoogleFonts.raleway(
                    fontSize: 28, fontWeight: FontWeight.w500),
              ),
              Text(
                  "Let's connect \nIndia's most trusted and popular share riding \nPlatform to make high profits",
                  style: styleGrey15),
              const SizedBox(height: 30),
              // isLoading
              //     ? const Center(
              //         child: CircularProgressIndicator(color: Colors.red),
              //       )
              //     :
              RoundButton(
                  text: "Driver",
                  color: Colors.red,
                  onTap: () {},
                  textColor: Colors.white),
              const SizedBox(height: 10),
              // isLoading
              //     ? const Center(
              //         child: CircularProgressIndicator(color: Colors.red),
              //       )
              //     :
              RoundButton(
                text: "Users",
                color: Colors.grey[700]!,
                onTap: () {
                  NavigatorPage.to(context, const PhoneAuth());
                },
                textColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

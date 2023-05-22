import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shubhyatri/driver/driver_controller/authservice/driver_auth_controller.dart';
import 'package:shubhyatri/user/controller/app_data.dart';
import 'package:shubhyatri/user/controller/authentication/authentication_controller.dart';
import 'package:shubhyatri/user/controller/contant.dart';
import 'package:shubhyatri/user/view/home.dart';
import 'package:shubhyatri/user/view/registration/phone_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppData()),
        ChangeNotifierProvider(create: (_) => AuthenticationController()),
        ChangeNotifierProvider(create: (_) => DriverAuthController()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ShubhYatri',
        theme: ThemeData(
            scaffoldBackgroundColor: Colors.grey[200],
            appBarTheme: AppBarTheme(
              titleTextStyle: styleWhite20,
              elevation: 0,
              backgroundColor: const Color(0xFF0071FF),
            )),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.red),
              );
            } else if (!snapshot.hasData) {
              return const PhoneAuth();
            } else {
              return const Home();
            }
          },
        ),
      ),
    );
  }
}

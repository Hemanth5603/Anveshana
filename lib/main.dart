import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:anveshana/screens/Auth/otp.dart';
import 'package:anveshana/screens/Auth/signup.dart';
import 'package:anveshana/screens/SplashScreen.dart';
import 'package:anveshana/screens/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'assets/images/img_paths.dart';
// import 'package:anveshana/screens/homepage.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'controllers/navigation_controller.dart';
import 'firebase_options.dart';

Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options:DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}



class MyApp extends StatelessWidget {
  MyApp({super.key});



  @override
  Widget build(BuildContext context) {

    final FirebaseAuth auth = FirebaseAuth.instance;
    if (auth.currentUser != null) {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          'phone': (context) => PhoneAuthScreen(),
          //'otp':(context) => OtpScreen(),
          'home':(context) => HomePage(),
          'navigator':(context) =>Navigation(),
        },
        theme: ThemeData(

          primarySwatch: Colors.blue,
        ),
        home: HomePage(),
      );
    } else {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          'phone': (context) => PhoneAuthScreen(),
          //'otp':(context) => OtpScreen(),
          'home':(context) => HomePage(),
          'navigator':(context) =>Navigation(),
        },
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: PhoneAuthScreen(),
      );
    }


    /*return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      //initialRoute: 'home',
      routes: {
        'phone': (context) => PhoneAuthScreen(),
        'otp':(context) => OtpScreen(),
        'home':(context) => HomePage(),
        'navigator':(context) =>Navigation(),

      },

      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );*/
  }
}






import 'dart:async';

import 'package:anveshana/screens/Auth/signup.dart';
import 'package:anveshana/screens/home_screen.dart';
import 'package:anveshana/screens/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);


  @override
  State<SplashScreen> createState() => _SplashScreenState();
}



class _SplashScreenState extends State<SplashScreen> {
  @override
  Future initState() async{
    super.initState();

    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> PhoneAuthScreen()));
    });
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        color: Colors.blue,
        child: Center(
          child: Text("Raghuite",style: TextStyle(color: Colors.white,fontSize: 30),),
        ),
      ),
    );
  }
}

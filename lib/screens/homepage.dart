import 'package:anveshana/controllers/database_controller.dart';
import 'package:anveshana/models/startup_post.dart';
import 'package:anveshana/screens/Auth/login.dart';
import 'package:anveshana/screens/Auth/otp.dart';
import 'package:anveshana/screens/Posts/post_screen.dart';
import 'package:anveshana/screens/Profile/profile_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Auth/signup.dart';
import 'Posts/camera_screen.dart';
import 'home_screen.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _stateExampleState();
}

// ignore: camel_case_types
class _stateExampleState extends State<HomePage> {

  int currentIndex = 1;

  var Tabs = [
    Home(),
    CameraScreen(),
    ProfilePage()
  ];
  final List<Widget> pages = [ Home(),CameraScreen(), ProfilePage()];

  PageController pageController = PageController(initialPage: 0);


  @override
  void initState() {
    super.initState();
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child:Stack(
             children: [
               IndexedStack(
                 index: currentIndex,
                 children: pages,
               ),
               /*PageView(
                 controller: pageController,
                 onPageChanged: (newIndex){
                   setState(() {
                     currentIndex = newIndex;
                   });
                 },
                 children: [
                   Home(),
                   CameraScreen(),
                   ProfilePage(),
                 ],
               ),*/

             ],
          )
        ),
      bottomNavigationBar: CurvedNavigationBar(
        height: 50,
        index: currentIndex,
        backgroundColor: Colors.grey.shade200,
        color: Colors.white,
        animationDuration: Duration(milliseconds: 300),

        items: const [
          Icon(
            Icons.home,
            color:Colors.black,
            size: 35,
          ),
          Icon(
            Icons.add,
            color:Colors.black,
            size: 40,
          ),
          Icon(
            Icons.person,
            color:Colors.black,
            size: 35,

          ),
        ],
        onTap: (index){
          //pageController.animateToPage(index, duration:Duration(milliseconds: 500), curve: Curves.ease);
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}











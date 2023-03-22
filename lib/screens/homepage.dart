import 'package:anveshana/controllers/database_controller.dart';
import 'package:anveshana/models/startup_post.dart';
import 'package:anveshana/screens/Auth/login.dart';
import 'package:anveshana/screens/Auth/otp.dart';
import 'package:anveshana/screens/post_screen.dart';
import 'package:anveshana/screens/profile_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Auth/signup.dart';
import 'home_screen.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _stateExampleState();
}

// ignore: camel_case_types
class _stateExampleState extends State<HomePage> {

  int currentIndex = 0;

  var Tabs = [
    Home(),
    PhoneAuthScreen(),
    ProfilePage(),
  ];


  @override
  void initState() {
    super.initState();
    /*final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUse
    final uid = user?.uid;

    try{
      await FirebaseFirestore.instance.collection("users").doc(uid).set({
        "Name":Name,
        "Phone": countrycode.text + PhoneNumber,
        "id": Uid.toString(),
      });
    }catch(e){
      print(e.toString());
      print("Cannot Create User !!!!");
    }*/

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        height: 60,
        index: currentIndex,
        backgroundColor: Colors.white,
        color: Colors.black,
        animationDuration: Duration(milliseconds: 300),
        items: const [
          Icon(
            Icons.home,
            color:Colors.white,
            size: 30,
          ),
          Icon(
            Icons.add,
            color:Colors.white,
            size: 30,
          ),
          Icon(
            Icons.person,
            color:Colors.white,
            size: 30,

          ),
        ],
        onTap: (index){
          setState(() {
            currentIndex = index;
          });
        },
      ),
      body: SafeArea(
        child:Tabs[currentIndex],
      ),
    );
  }
}





Widget fetchData(){
  return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection("posts")
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
        if(snapshot.hasError){
          return Text("Something wrong");
        }
        if(snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child:CupertinoActivityIndicator(),
          );
        }
        if(snapshot.data!.docs.isEmpty){
          return Text("No Data found");
        }
        if(snapshot != null && snapshot.data != null){

          return ListView.builder(
            //scrollDirection: Axis.vertical,
            itemCount: 10,//snapshot.data!.docs.length,
            itemBuilder: (context,index){
              return Container(
                height: 100,
                color: Colors.black,
              );
            },
          );
        }
        //Text(snapshot.data!.docs[index]['Name'],style: TextStyle(fontSize: 12),),
        return Container();

      }
  );
}

//Card(color:Colors.grey,child: ListTile(title: Text(snapshot.data!.docs[index]['Name']),),);







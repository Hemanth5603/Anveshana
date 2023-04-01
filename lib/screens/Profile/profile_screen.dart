import 'dart:async';
import 'dart:io';

import 'package:anveshana/screens/Auth/signup.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'Profile_Widgets/user_posts.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}
class _ProfilePageState extends State<ProfilePage> {
  var UserPhoneNumber = '';
  var UserName = '';
  String SelectedImage = "";
  String UserId = "";
  String UserProfileImage = "";
  String TotalPosts ='';




  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    /*
    final FirebaseAuth CurrUser = FirebaseAuth.instance;
    final User? user = CurrUser.currentUser;
    */
    getuserData();
    getTotalCount();

  }





  Future getuserData() async {
    //Code to Get UID of current user
    final FirebaseAuth CurrUser = FirebaseAuth.instance;
    final User? user = CurrUser.currentUser;
    final uid = user?.uid;
    // code to get current user details
    var collection = FirebaseFirestore.instance.collection('users');
    var docSnapshot = await collection.doc(uid).get();
    Map<String, dynamic>? data = docSnapshot.data();
    Timer(Duration(milliseconds: 1000), () {
      setState(() {
        UserName = data?['Name'];
        UserPhoneNumber = data?['Phone'];
        UserId = data?['id'];
        UserProfileImage = data?['ProfileImage'];
      });
    });
    print("User Phonee  ------- $UserPhoneNumber");
  }

  void getTotalCount() async{
      final ref = await FirebaseFirestore.instance
        .collection('users').doc(UserId)
        .collection('UserPosts').snapshots();
      setState(() {
        TotalPosts =  ref.length.toString();
      });
    print("Total Posts ------- $TotalPosts");
  }

  @override
  Widget build(BuildContext context) {
    double ScreenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 0,),
                Row(
                  children: [
                    Expanded(
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey.shade200,

                          ),
                          child:Row(
                            
                            children: [
                              SizedBox(width: 0,),
                              Padding(
                                padding: EdgeInsets.only(left:20,top:0),
                                child: Text("Profile",style: TextStyle(fontSize: 25),),
                              ),
                            ],
                          ),
                        )
                    ),
                  ],
                ),
                SizedBox(height: 5,),
                Row(
                  children: [
                    Expanded(
                        child: Container(
                          height: 170,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                  color: Colors.grey.shade400,
                                  width: 1
                              )


                          ),
                          child: Column(
                            children: [
                              SizedBox(height: 10,),
                              Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(width:12),
                                      Container(
                                        height: 80,
                                        width: 80,
                                        alignment: Alignment.center,
                                        child: SelectedImage == "" &&
                                            UserProfileImage == ""
                                            ? Center(child: Center(
                                          child: Container(
                                            width: 50,
                                            height: 50,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(
                                                  50),
                                              color: Colors.grey.shade400,
                                            ),
                                            child: IconButton(
                                              onPressed: () async {
                                                SelectedImage =
                                                await SelectPostFetchUserProfileImage(
                                                    UserId);
                                              },
                                              icon: Icon(Icons.add),
                                            ),
                                          ),
                                        )
                                        ) : CachedNetworkImage(
                                          imageUrl: UserProfileImage,
                                          imageBuilder: (context,
                                              imageProvider) =>
                                              Container(
                                                height: 120,
                                                width: 120,
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius
                                                        .circular(60),
                                                    image: DecorationImage(
                                                      image: imageProvider,
                                                      fit: BoxFit.cover,
                                                    )
                                                ),
                                              ),
                                          placeholder: (context, url) =>
                                              Container(
                                                alignment: Alignment.center,
                                                child: LoadingAnimationWidget
                                                    .prograssiveDots(
                                                    color: Colors.grey.shade300,
                                                    size: 30),
                                              ),
                                          errorWidget: (context, url, error) =>
                                          const Icon(Icons.error_outline_sharp),
                                        ),
                                      ),
                                      SizedBox(width: 15,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [

                                          Text(UserName, style: TextStyle(fontSize: 25,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),),
                                          SizedBox(height: 2,),
                                          Text(UserPhoneNumber,
                                            style: TextStyle(fontSize: 15, color: Colors.grey),)
                                        ],
                                      )

                                    ],
                                  )
                              ),
                              SizedBox(height: 0,),
                              Padding(
                                padding: const EdgeInsets.only(left:110),
                                child: Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text("52", style: TextStyle(
                                            fontSize: 17,fontWeight: FontWeight.bold)),
                                        SizedBox(height: 2,),

                                        Text("Likes", style: TextStyle(
                                            fontSize: 15,fontWeight: FontWeight.w400),),
                                      ],
                                    ),
                                    SizedBox(width: 50,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text("20", style: TextStyle(
                                            fontSize: 17,fontWeight: FontWeight.bold)),
                                        SizedBox(height: 2,),

                                        Text("Streak", style: TextStyle(
                                            fontSize: 15,fontWeight: FontWeight.w400),),
                                      ],
                                    ),
                                    SizedBox(width: 50,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text("1", style: TextStyle(
                                            fontSize: 17,fontWeight: FontWeight.bold)),
                                        SizedBox(height: 2,),

                                        Text("Posts", style: TextStyle(
                                            fontSize: 15,fontWeight: FontWeight.w400),),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                    )
                  ],
                ),
                SizedBox(height: 10,),
                Container(
                  height: 25,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.grid_on_outlined,size: 30,),
                    ],
                  ),
                ),
                SizedBox(height: 8,),
                Divider(
                  height: 5,
                  color: Colors.grey,
                ),
                SizedBox(height: 8,),
                Container(
                  height:ScreenHeight*0.5,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: getUserPosts(UserId),
                ),
                Row(
                  children: [
                    Expanded(child: InkWell(
                      onTap: () {
                        _signOut();
                        Get.to(PhoneAuthScreen());
                      },
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(child: Text("LogOut", style: TextStyle(
                            fontSize: 20, color: Colors.white),)),
                      ),
                    ))
                  ],
                ),
              ],
            ),
          ),
        ),
    );
  }



  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future SelectPostFetchUserProfileImage(uid) async {
    String url = "";
    String uniqueFileName = DateTime
        .now()
        .microsecondsSinceEpoch
        .toString();
    ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 30);
    if (file != null) {
      print("File path: " + file.path);
      setState(() {
        if (file.path != null) {
          SelectedImage = file.path;
        }
      });
      final ref = FirebaseStorage.instance
          .ref()
          .child('profile_images').child(uniqueFileName);

      Get.snackbar("Please Wait ! ", "Posting ...",
        duration: Duration(seconds: 2),
        backgroundColor: Colors.black,
        colorText: Colors.white,
        snackStyle: SnackStyle.FLOATING,
        dismissDirection: DismissDirection.startToEnd,
        icon: Icon(Icons.send_rounded, color: Colors.white,),
      );
      await ref.putFile(File(SelectedImage));
      url = await ref.getDownloadURL();
    }
    try {
      await FirebaseFirestore.instance.collection("users").doc(uid).update({
        "ProfileImage": url,
      });
    } catch (e) {
      print(e.toString());
      print("cannot make it !!!");
    }
  }
}

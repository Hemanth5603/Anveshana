import 'package:anveshana/screens/Auth/signup.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {




  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    final FirebaseAuth CurrUser = FirebaseAuth.instance;
    final FirebaseFirestore ref = FirebaseFirestore.instance;

    final User? user = CurrUser.currentUser;
    final uid = user?.uid;
    final data = ref.collection('users').doc(uid).get();



  }

  @override
  Widget build(BuildContext context) {
    String userName = "";


    final number ="";
    return Scaffold(
      body:Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Expanded(
                    child: Container(
                      height: 220,
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
                          SizedBox(height: 20,),
                          Center(
                            child: CachedNetworkImage(
                              imageUrl:"https://firebasestorage.googleapis.com/v0/b/anveshana-121f4.appspot.com/o/post_images%2F1679336734270545?alt=media&token=8664612a-feaa-4a03-bbbb-3864d19301e0",
                              imageBuilder: (context, imageProvider) => Container(
                                height: 120,
                                width: 120,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(60),
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    )
                                ),
                              ),
                              placeholder: (context,url) => Container(
                                alignment:Alignment.center,
                                child: CircularProgressIndicator(color: Colors.black,),
                              ),
                              errorWidget: (context,url,error) =>Image(image: AssetImage('assets/images/auth_images/startup.png')),


                            )
                          ),
                          SizedBox(height: 10,),
                          Text("S Hemanth Srinivas",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                          SizedBox(height: 5,),
                          Text("+91 7997435603",style: TextStyle(fontSize: 15,color: Colors.grey),)
                        ],
                      ),
                    )
                )
              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                Expanded(
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                              color: Colors.grey.shade400,
                              width: 1
                          ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left:70),
                        child: Row(
                          children: [
                            Text("Likes :",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                            SizedBox(width: 5,),
                            Text("0",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                            SizedBox(width: 60,),
                            Text("Posts :",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                            SizedBox(width: 5,),
                            Text("5",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ),
                )
              ],
            ),
            SizedBox(height: 15,),
            Row(
              children: [
                Expanded(child: InkWell(
                  onTap:(){
                    _signOut();
                    Get.to(PhoneAuthScreen());
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(child: Text("LogOut",style: TextStyle(fontSize: 20,color: Colors.white),)),
                  ),
                ))
              ],
            )



          ],
        ),
      )


    );




}
  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();

  }

  Future getData(uid) async{

  }
}
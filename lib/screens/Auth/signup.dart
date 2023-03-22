import 'package:anveshana/main.dart';
import 'package:anveshana/screens/Auth/otp.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class PhoneAuthScreen extends StatefulWidget {
  const PhoneAuthScreen({Key? key}) : super(key: key);

  static String verify = "";

  @override
  State<PhoneAuthScreen> createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {

  TextEditingController countrycode = TextEditingController();
  var PhoneNumber = "";
  var Name = "";

  void initState(){
    countrycode.text = "+91";
    super.initState();
  }


  @override
  Widget build(BuildContext context){
    final FirebaseAuth user = FirebaseAuth.instance;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Create Account in Raghuite... ",style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold),),
            SizedBox(height: 30,),

            TextField(
              onChanged: (value){
                Name= value;
              },
              decoration:InputDecoration(
                hintText: 'Enter Your Name',
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(15)
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade600, width: 2.0),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            SizedBox(height: 15,),

            TextField(
              onChanged: (value){
                PhoneNumber= value;
              },
              keyboardType: TextInputType.number,
              decoration:InputDecoration(
                hintText: 'Enter Your Phone Number',
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(15)
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade600, width: 2.0),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            SizedBox(height: 20,),
            Row(
              children: [
                Expanded(
                    child: InkWell(
                      splashColor: Colors.black,
                      child: Container(
                          width: 200,
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Center(
                            child: Text("Send OTP",style: TextStyle(color: Colors.white,fontSize: 20),),
                          )

                      ),
                      onTap: ()async{
                        await FirebaseAuth.instance.verifyPhoneNumber(
                          phoneNumber: countrycode.text + PhoneNumber,
                          verificationCompleted: (PhoneAuthCredential credential) {},
                          verificationFailed: (FirebaseAuthException e) {},
                          codeSent: (String verificationId, int? resendToken) {
                            PhoneAuthScreen.verify = verificationId;
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => OtpScreen(UserName: Name,PhoneNumber: PhoneNumber)));
                          },
                          codeAutoRetrievalTimeout: (String verificationId) {},
                        );
                        Get.snackbar("Verification","OTP SENT.....",
                          backgroundColor: Colors.black,
                          colorText: Colors.white,
                          icon: Icon(Icons.send_rounded,color: Colors.white,),
                          snackPosition: SnackPosition.BOTTOM,
                        );
                        Get.snackbar("Please Wait !","Redirecting.....",
                          backgroundColor: Colors.black,
                          colorText: Colors.white,
                          icon: Icon(Icons.timer,color: Colors.white,),
                          snackPosition: SnackPosition.BOTTOM,
                        );
                        /*try{
                          await FirebaseFirestore.instance.collection("users").doc(Uid).set({
                            "Name":Name,
                            "Phone": countrycode.text + PhoneNumber,
                            "id": Uid.toString(),
                          });
                        }catch(e){
                          print(e.toString());
                          print("Cannot Create User !!!!");
                        }*/

                      },
                    )
                ),
              ],
            )

          ],
        ),
      )

    );
  }
}

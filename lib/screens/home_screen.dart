import 'dart:core';
import 'dart:io';
import 'dart:core';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String imageUrl = '';
  String caption = '';


  @override
  void initState() {
    super.initState();

    //fetchData();
  }

  Future<void> _handleRefresh() async{
    return await Future.delayed(Duration(milliseconds: 500));
  }





  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(

          children: [
            Row(
              children: [
                Expanded(
                    child: Container(
                      height: 40,
                      padding: EdgeInsets.only(left: 10,top: 6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),

                          border: Border.all(
                            color: Colors.black,
                            width: 2,
                          ),
                      ),
                      child: Text("Snap Post",style: TextStyle(fontSize:20,color: Colors.black),),
                    )
                ),
              ],
            ),
            SizedBox(height: 10,),
            Container(
              padding: EdgeInsets.only(top: 5,bottom: 5),
              height: height*0.8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.grey.shade200,
              ),
              child: LiquidPullToRefresh(
                onRefresh: _handleRefresh,
                child: fetchData(),
                backgroundColor: Colors.white,
                color: Colors.black,
                animSpeedFactor: 10,
              ),
            )



          ],
        )
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
            itemExtent: 590.0,
            //scrollDirection: Axis.vertical,
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context,index){
              return Row(
                children: [
                  Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 0,right: 0),
                        child: Container(
                          height: 550,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey.shade200,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [

                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center ,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(width: 6,),
                                  CachedNetworkImage(
                                    imageUrl:"https://firebasestorage.googleapis.com/v0/b/anveshana-121f4.appspot.com/o/post_images%2F1679336734270545?alt=media&token=8664612a-feaa-4a03-bbbb-3864d19301e0",
                                    imageBuilder: (context, imageProvider) => Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(50),
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
                                  ),
                                  SizedBox(width: 10,),
                                  Text("S Hemanth Srinivas"),
                                ],
                              ),
                              SizedBox(height: 8,),

                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                          child: CachedNetworkImage(
                                            imageUrl: snapshot.data!.docs[index]['image'],
                                            imageBuilder: (context, imageProvider) => Container(
                                              height: 450,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(topRight: Radius.circular(8),topLeft:Radius.circular(8)),
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
                                ],
                              ),
                              SizedBox(height: 0,),
                              Row(
                                children: [
                                  Expanded(
                                      child: Container(
                                        height: 50,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(bottomRight: Radius.circular(10),bottomLeft: Radius.circular(10)),
                                          color: Colors.grey.shade300,
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.all(6),
                                          child: Text(snapshot.data!.docs[index]['caption']),
                                        ),
                                      ),
                                  )
                                ],
                              ),
                              SizedBox(height: 0,),
                            ],
                          ),
                        ),
                      )
                  ),
                  SizedBox(height: 20,),
                ],
              );
            },
          );
        }
        //Text(snapshot.data!.docs[index]['Name'],style: TextStyle(fontSize: 12),),
        return Container();

      }
  );
}


/*
Container(
                                            height: 450,
                                            padding: EdgeInsets.only(top: 5),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.only(topLeft: Radius.circular(12),topRight: Radius.circular(12)),
                                              child: Image.network(
                                                snapshot.data!.docs[index]['image'],filterQuality: FilterQuality.low,
                                                fit: BoxFit.cover,
                                                height: 200,
                                                width: double.infinity,
                                              ),
                                            )
                                    )
* */


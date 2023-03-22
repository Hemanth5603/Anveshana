import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../models/startup_post.dart';

class PostScreen extends StatefulWidget{
  const PostScreen({Key? key}) : super(key:key);

  @override
  State<PostScreen> createState() => PostPage();

}


class PostPage extends State<PostScreen>{

  String imageUrl = '';
  String selectedimage = "";



  var Post = post(
      name: "User",
      caption: "", image: 'url',
  );

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    bool _isLoading=false;

    TextEditingController CaptionController = TextEditingController();
    return Scaffold(
      body:SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey.shade200,

                        ),
                        child:Padding(
                            padding: EdgeInsets.only(left:20,top:10),
                            child: Text("Create a Post",style: TextStyle(fontSize: 25),),
                          ),
                      )
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Container(
                height: 300,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: selectedimage == ''
                ? Center(child: Center(
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.grey.shade400,
                    ),
                    child: IconButton(
                      onPressed: () async{
                        selectedimage= await selectImageFromGallery();
                        },
                      icon:Icon(Icons.add),
                    ),
                  ),
                ))
                    : Container(
                    height: 450,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(15),
                    ),
                  child: FittedBox(
                    child: Image.file(File(selectedimage)),
                    fit: BoxFit.cover,
                  ),

                ) ,
              ),
              SizedBox(height:10),
              TextField(
                controller: CaptionController,
                decoration:InputDecoration(
                  hintText: 'Write a Caption...',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(15)
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade400, width: 2.0),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              SizedBox(height: height*0.22,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    child:Container(
                      width:width*0.45,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.black,
                            width: 2,
                          )
                      ),
                      child: Center(
                        child: Text("Gallery",style: TextStyle(color: Colors.black,fontSize: 20),),
                      ),
                    ),
                    onTap: ()async{
                      selectedimage = await selectImageFromGallery();
                      postImage(selectedimage);
                      print(imageUrl);
                    },
                  ),
                  SizedBox(width: 10,),
                  InkWell(
                    child:Container(
                      width: width*0.45,
                      height: 50,
                      decoration: BoxDecoration(

                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Colors.black,
                          width: 2,
                        )
                      ),
                      child: const Center(
                        child: Text("Camera",style: TextStyle(color: Colors.black,fontSize: 20),),
                      ),
                    ),
                    onTap: () async{
                      selectedimage = await selectImageFromCamera();
                      postImage(selectedimage);
                      print(imageUrl);

                    },
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      child:Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment:CrossAxisAlignment.center,
                            children: [
                              Text("Post",style: TextStyle(color: Colors.white,fontSize: 20),),
                            ],
                          ),
                        ),
                      ),
                      onTap: (){
                        createPost(Post, imageUrl,CaptionController.text);
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }


  Future selectImageFromGallery() async{
    ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
    if(file != null){
      print("File path: "+file.path);
      setState(() {
        if(file.path != null){
          selectedimage = file.path;
        }
      });
      return file.path;
    }else{
      return '';
    }
  }


  Future selectImageFromCamera() async{
    ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.camera);
    if(file != null){
      print("File path: "+file.path);
      setState(() {
        if(file.path != null){
          selectedimage = file.path;
        }
      });
      return file.path;
    }else{
      return '';
    }
  }


 // Function to post image in firebase Storage
  Future postImage(file) async {
    String url = "";
    String uniqueFileName = DateTime.now().microsecondsSinceEpoch.toString();
    final ref = FirebaseStorage.instance
        .ref()
        .child('post_images').child(uniqueFileName);
    await ref.putFile(File(file));
    url = await ref.getDownloadURL();
    imageUrl = url;
    print("URL is : "+url);
  }


  // Function to insert data into firebase firestore
  void createPost(Post,ImageUrl,caption) async{
    var check=0;
    try{
      await FirebaseFirestore.instance.collection("posts").doc().set({
        "Name":"User",
        "caption": caption,
        "image" :imageUrl,
      });
      check=1;
    }catch(e){
      print(e.toString());
      print("cannot make it !!!");
    }
    if(check==1) print("Successully posted ");
  }





















  /*Future OpenCamera() async{
    ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.camera);
    print('${file?.path}');
    if(file==null) return;
    String uniqueFileName = DateTime.now().microsecondsSinceEpoch.toString();

    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = referenceRoot.child('post_images');

    Reference referenceImageToUpload = referenceDirImages.child(uniqueFileName);

    try{
      referenceImageToUpload.putFile(File(file!.path));
      imageUrl = (await referenceImageToUpload.getDownloadURL()).toString();
      print("urllll"+imageUrl);
      await FirebaseFirestore.instance.collection("startup").doc().set({
        "Name":"User",
        "caption":'this is a post',
        "image" :imageUrl,
      });



    }catch(e){
      print(e.toString());
    }
  }*/


}









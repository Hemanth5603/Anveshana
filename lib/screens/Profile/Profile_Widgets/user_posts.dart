

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

Widget getUserPosts(UserId) {
  return StreamBuilder(
    stream: FirebaseFirestore.instance
        .collection('users').doc(UserId)
        .collection('UserPosts')
        .orderBy("TimeStamp", descending: true)
        .snapshots(),

    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if (snapshot.hasError) {
        return Text("Something Wrong");
      }
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(
          child: CupertinoActivityIndicator(),
        );
      }
      if (snapshot.data!.docs.isEmpty) {
        return Text("No Data found");
      }

      if (snapshot != null && snapshot.data != null) {
        return GridView.builder(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 150,
              childAspectRatio: 1,
              crossAxisSpacing: 2,
              mainAxisSpacing: 2,

            ),
            itemCount: snapshot.data!.docs.length,

            itemBuilder: (context, index) {
              return Container(
                color: Colors.grey,
                child: Stack(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                              child: Container(
                                height: 450,
                                child: CachedNetworkImage(
                                  imageUrl: snapshot.data!.docs[index]['image'],
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                        height: 450,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(8),
                                                topLeft: Radius.circular(8)),
                                            image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.cover,
                                            )
                                        ),
                                      ),
                                  placeholder: (context, url) =>
                                      Container(
                                        alignment: Alignment.center,
                                        child: LoadingAnimationWidget.beat(
                                            color: Colors.grey.shade300,
                                            size: 20),
                                      ),
                                  errorWidget: (context, url, error) => Image(
                                      image: AssetImage(
                                          'assets/images/auth_images/startup.png')),


                                ),
                              )
                          ),
                        ],
                      ),
                      Positioned(
                          bottom: -5, left: 83,
                          child: IconButton(
                            icon: Icon(Icons.delete, color: Colors.white,),
                            onPressed: () async {
                              var DeletePostDocumentId = await snapshot.data!
                                  .docs[index]['PostDocumentId'];
                              var DeleteSelfId = await snapshot.data!
                                  .docs[index]['CurrentDocumentId'];

                              await FirebaseFirestore.instance.collection(
                                  "posts").doc(DeletePostDocumentId).delete();
                              await FirebaseFirestore.instance.collection(
                                  'users').doc(UserId)
                                  .collection('UserPosts')
                                  .doc(DeleteSelfId)
                                  .delete();
                            },
                          )
                      ),
                    ]
                ),
              );
            }
        );
      }
      return Container();
    },
  );
}


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled123/Scrrens/account.dart';

Future<List<Map<String,dynamic>>> getUserslist() async {
  final CollectionReference collection = FirebaseFirestore.instance.collection('customers');
  QuerySnapshot querySnapshot = await collection.get();


  List<Map<String, dynamic>> users = querySnapshot.docs.map((doc) {
    return doc.data() as Map<String, dynamic>;
  }).toList();

  return users;
}

Future<void> ChangePass(String CurrentPass, String NewPass) async{
  FirebaseAuth _auth=FirebaseAuth.instance;
  var currentUserID=_auth.currentUser!.uid;
  User mine=_auth.currentUser!;

  List<Map<String, dynamic>> Banday = await getUserslist();

  for (var user in Banday) {
    if (user['uid'] == currentUserID) {
      if(user['password']==CurrentPass){
          mine.updatePassword(NewPass);

          Get.snackbar(
            "Password is Updated Sccessfully" ,
            "",
            duration: Duration(seconds: 3),
            colorText: Colors.white,



            backgroundColor: Colors.green.shade700,
          );
          Get.off(AccountScreen());
      }
      else{
        Get.snackbar(
          "Invalid Current Password" ,
          "",
          duration: Duration(seconds: 3),
          colorText: Colors.white,


          backgroundColor: Colors.green.shade700,
        );
      }
      break;
    }
  }



}
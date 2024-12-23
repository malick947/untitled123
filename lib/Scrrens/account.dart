import 'package:flutter/material.dart';
import 'package:untitled123/Auth_Services/Login.dart';
import 'package:get/get.dart';
import 'package:untitled123/Auth_Services/SignUp.dart';
class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Account")),
      ),
      body: Center(child: Column(
        children: [
          ElevatedButton(onPressed: (){
            Get.to(Login());
          }, child: Text("Login Screen")),
          ElevatedButton(onPressed: (){
            Get.to(Signup());
          }, child: Text("SignUp"))
        ],
      ),),
    );;
  }
}
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled123/Auth_Services/SignUp.dart';
import 'package:untitled123/homescreen.dart';
import '../UI_helper/Custom_widgets.dart';
import 'package:get/get.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool loading=false;
  String? DropDownValue;
  FirebaseAuth _auth=FirebaseAuth.instance;
  var email = TextEditingController();
  var password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _formkey = GlobalKey<FormState>();
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;


    return Scaffold(
      body: Container(
        height: height,
        width: width,
        color: Colors.green,
        child: Column(
          children: [
            SizedBox(height: height / 4),
            Container(
              height: height - height / 4,
              width: width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35),
                  topRight: Radius.circular(35),
                ),
              ),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 30, vertical: 40),
                child: Column(
                  spacing: 20,
                  children: [
                    Text(
                      "Welcome Back!!!",
                      style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    Form(
                      key: _formkey,
                      child: Column(
                        spacing: 30,
                        children: [
                          TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter Email";
                              }
                              return null;
                            },
                            controller: email,
                            decoration: InputDecoration(
                              hintText: "Email",
                              prefixIcon: Icon(Icons.email),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                  width: 2,
                                  color: Colors.green.shade700,
                                ),
                              ),
                            ),
                          ),
                          TextFormField(
                            obscureText: true,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter Password";
                              }
                              return null;
                            },
                            controller: password,
                            decoration: InputDecoration(
                              hintText: "Password",
                              prefixIcon: Icon(Icons.password),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                  width: 2,
                                  color: Colors.green.shade700,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: RoundButton(
                              loading: loading,
                              text: 'Login',
                              onTap: () {
                                if (_formkey.currentState!.validate()) {

                                  // Handle login
                                  setState(() {
                                    loading=true;
                                  });
                                  _auth.signInWithEmailAndPassword(email: email.text.trim(), password: password.text.trim()).then((value){
                                    setState(() {
                                      loading=false;
                                    });
                                    Get.off(Homescreen());
                                  });
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          onTap: () {
                            // Action for Forgot Password
                          },
                        ),
                      ],
                    ),
                    RoundButton(
                      text: 'Create Account',
                      onTap: () {
                        // Action for creating Account
                        Get.to(Signup());
                      },
                    ),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
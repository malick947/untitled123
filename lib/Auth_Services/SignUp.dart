import 'package:flutter/material.dart';

import '../UI_helper/Custom_widgets.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  String? DropDownValue;
  String hinttext="Select your role";
  @override
  Widget build(BuildContext context) {

    final _formkey = GlobalKey<FormState>();
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    var email = TextEditingController();
    var password = TextEditingController();
    var Username=TextEditingController();

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
                  //spacing: 20,
                  children: [

                    Form(
                      key: _formkey,
                      child: Column(
                        //spacing: 30,
                        children: [

                          TextFormField(

                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter Username";
                              }
                              return null;
                            },
                            controller: Username,
                            decoration: InputDecoration(
                              hintText: "Username",
                              prefixIcon: Icon(Icons.wifi_protected_setup),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                  width: 2,
                                  color: Colors.green.shade700,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 30,),
                          TextFormField(

                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Enter email";
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
                          SizedBox(height: 30,),
                          TextFormField(

                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Set password";
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
                          SizedBox(height: 30,),
                          DropdownButtonHideUnderline(child: DropdownButton2(
                            value: DropDownValue,
                              isExpanded: true,
                              hint: Text(
                                hinttext,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                              onChanged: (String? value) {
                                setState(() {
                                  DropDownValue = value;
                                  hinttext=value!;
                                });
                              },
                              items: [
                                DropdownMenuItem(
                                    child: Text("Male Student"),
                                value: 'Male Student',),
                                DropdownMenuItem(
                                  child: Text("Female Student"),
                                  value: 'Female Student',),
                                DropdownMenuItem(
                                  child: Text("Faculty or Staff"),
                                  value: 'Faculty or Staff',)
                              ],

                            menuItemStyleData: const MenuItemStyleData(
                              height: 40,
                            ),)
                          ),
                          SizedBox(height: 30,),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: RoundButton(
                              text: 'SignUp',
                              onTap: () {
                                //Must be check role slot of user
                                if (_formkey.currentState!.validate()) {
                                  // Handle login
                                }
                              },
                            ),
                          ),
                        ],
                      ),
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

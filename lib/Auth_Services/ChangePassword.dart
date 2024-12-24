import 'package:flutter/material.dart';
import 'package:untitled123/Auth_Services/Password_Service.dart';

import '../UI_helper/Custom_widgets.dart';

class Changepassword extends StatefulWidget {
  const Changepassword({super.key});

  @override
  State<Changepassword> createState() => _ChangepasswordState();
}

class _ChangepasswordState extends State<Changepassword> {
  bool loading=false;
  final _formkey = GlobalKey<FormState>();
  var currentPassword=TextEditingController();
  var newPassword=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Change Password"),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 30,vertical: 50),

        child: Form(
        key: _formkey,
        child: Column(
          spacing: 30,
          children: [
            TextFormField(
              obscureText: true,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Enter Current Password";
                }
                return null;
              },
              controller: currentPassword,
              decoration: InputDecoration(
                hintText: "Current Password",
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
            TextFormField(
              obscureText: true,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Enter New Password";
                }
                return null;
              },
              controller: newPassword,
              decoration: InputDecoration(
                hintText: "New Password",
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

                text: 'Submit',
                onTap: ()async {
                  if (_formkey.currentState!.validate()) {
                    setState(() {
                      loading=true;
                    });
                    await ChangePass(currentPassword.text.trim(), newPassword.text.trim());
                    setState(() {
                      loading=false;
                    });

                    //then change password
                  }
                },
              ),
            ),
          ],
        ),
      ),),
    );
  }
}

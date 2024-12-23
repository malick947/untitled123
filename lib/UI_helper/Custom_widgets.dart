import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
final VoidCallback onTap;
final text;
bool loading;
RoundButton({required this.text,required this.onTap,this.loading=false});



@override
Widget build(BuildContext context) {
  double height=MediaQuery.of(context).size.height;
  double width=MediaQuery.of(context).size.width;
  return InkWell(
    onTap: onTap,
    child: Container(
      height: height/13,
      width: width/1.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.green.shade700,
      ),
      child:loading ? Center(child: CircularProgressIndicator(color: Colors.white,)) : Center(child: Text(text,style: TextStyle(color: Colors.white,fontSize: height/35),)),
    ),
  );
}
}
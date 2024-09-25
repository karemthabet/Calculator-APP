import 'package:flutter/material.dart';

class Custombutton extends StatelessWidget {
  const Custombutton({
    super.key, 
    required this.buttontext,
    required this.textcolor,
    required this.buttoncolor,
    required this.tapped});
 final String buttontext;
 final  Color buttoncolor;
 final  Color textcolor;
 final  void Function()tapped;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          minimumSize: const Size(80, 80), 
          backgroundColor: buttoncolor,
          foregroundColor: textcolor,
          textStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: tapped,
        child: Text(buttontext),
      ),
    );
  }
}



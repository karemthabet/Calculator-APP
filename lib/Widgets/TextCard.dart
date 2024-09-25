import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';



class Textcard extends StatelessWidget {
  const Textcard({super.key,required this.color,required this.txtinput});
 final Color color;
 final String txtinput;



  @override
  Widget build(BuildContext context) {
    return  Container(
            alignment: Alignment.centerRight,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            margin: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
            height: 50,
            width: double.infinity,
            child: AutoSizeText(
              txtinput,
              style: TextStyle(
                  color:color,
                  fontSize: 35,
                  fontWeight: FontWeight.bold),
            ),
          );
  }
}
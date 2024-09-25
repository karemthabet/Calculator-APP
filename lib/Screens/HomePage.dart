import 'package:auto_size_text/auto_size_text.dart';
import 'package:calculator/Widgets/CustomButton.dart';
import 'package:calculator/Widgets/TextCard.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

String userAsk = '';
String userHint = '';
String userAnswer = '';
String answer = '';

   class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Homepage> {
  List<String> buttonsText = [
    'AC',
    'Del',
    '%',
    '÷',
    '7',
    '8',
    '9',
    'x',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '+',
    '0',
    '.',
    'Ans',
    '=',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff9efe5),
      appBar: AppBar(
        elevation: 20,
        shadowColor: const Color(0xffa8b3b6),
        centerTitle: true,
        backgroundColor: const Color(0xffd27d2d),
        title: const Text(
          'Calculator',
          style: TextStyle(
              fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Container(
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            margin: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
            height: 50,
            width: double.infinity,
            child: AutoSizeText(
              userAsk,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 35,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Textcard(color: Colors.red, txtinput: userHint),
          Textcard(color: Colors.black, txtinput: userAnswer),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 6,
                crossAxisSpacing: 3,
                mainAxisExtent: 80,
              ),
              itemCount: buttonsText.length,
              itemBuilder: (context, index) {
                if (buttonsText[index] == 'AC') {
                  return Custombutton(
                      buttontext: buttonsText[index],
                      textcolor: Colors.white,
                      buttoncolor: const Color(0xffd27d2d),
                      tapped: () {
                        setState(() {
                          userAnswer = '';
                          userAsk = '';
                          userHint = '';
                        });
                      });
                } else if (buttonsText[index] == 'Del') {
                  return Custombutton(
                      buttontext: buttonsText[index],
                      textcolor: Colors.white,
                      buttoncolor: const Color(0xffd27d2d),
                      tapped: () {
                        setState(() {
                          if (userAsk.isNotEmpty)
                          {
                            userAsk = userAsk.substring(0, userAsk.length - 1);
                          }
                        });
                      });
                } else if (buttonsText[index] == 'Ans') {
                  return Custombutton(
                      buttontext: buttonsText[index],
                      textcolor: Colors.black,
                      buttoncolor: const Color(0xfff4dfca),
                      tapped: () {
                        setState(() {
                          userAsk += answer;
                        });
                      });
                } else if (buttonsText[index] == '%' ||
                    buttonsText[index] == '÷' ||
                    buttonsText[index] == 'x' ||
                    buttonsText[index] == '-' ||
                    buttonsText[index] == '+') {
                  return Custombutton(
                      buttontext: buttonsText[index],
                      textcolor: Colors.white,
                      buttoncolor:  const Color(0xffd27d2d),
                      tapped: () {
                        setState(() {
                          userAsk += buttonsText[index];
                        });
                      });
                } else if (buttonsText[index] == '=') {
                  return Custombutton(
                      buttontext: buttonsText[index],
                      textcolor: Colors.black,
                      buttoncolor: const Color(0xffFFBC7C),
                      tapped: () {
                        setState(() {
                          equal();
                          if (userAnswer.endsWith('.0')) {
                            userAnswer = userAnswer.replaceAll('.0', '');
                          }
                          if (userAnswer.length == 1) {
                            userHint = ' 🤔 انت شغلتني عشان دي ';
                          }
                          if (userAnswer.length > 8) {
                            userHint = ' بتعجزني كدا مثلا طب هحسبها برده ';
                          }
                          answer = userAnswer;
                        });
                      });
                } else {
                  return Custombutton(
                      buttontext: buttonsText[index],
                      textcolor: Colors.black,
                      buttoncolor: const Color(0xfff4dfca),
                      tapped: () {
                        setState(() {
                          userAsk += buttonsText[index];
                        });
                      });
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void equal() {
    String input = userAsk;
    try {
      input = input.replaceAll('x', '*');
      input = input.replaceAll('÷', '/');
      Parser p = Parser();
      Expression exp = p.parse(input);
      ContextModel cm = ContextModel();
      double finalOutput = exp.evaluate(EvaluationType.REAL, cm);
      userAnswer = finalOutput.toString();

      if (userAnswer.endsWith('.0')) {
        userAnswer = userAnswer.replaceAll('.0', '');
      }

      answer = userAnswer;
    } catch (e) {
      if (input.endsWith('+')) {
        userHint = "جالي الضغط 🤕 هتجمع ايه ";
      } else if (input.endsWith('*')) {
        userHint = " 🤬 نسيت تضرب ف ايه يعم";
      } else if (input.endsWith('-')) {
        userHint = " 😏 عندي السكر هتطرح ايه";
      } else if (input.endsWith('/')) {
        userHint = " نسيت تقسم علي كام 🙄 هنهزر ؟";
      } else if (input.endsWith('%')) {
        userHint = 'دخل عمليه صحيحة ي بشمهندس';
      } else {
        userAnswer = 'Error';
      }
    }
  }
}

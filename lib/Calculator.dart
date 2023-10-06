import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String result = '';
  String _input = '';
  int x = 0;
  TextEditingController textEditingController = TextEditingController();

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  void fach(int t) {
    setState(() {});
  }

  void addToInput(String value) {
    setState(() {
      _input += value;
      textEditingController.text = _input;
    });
  }

  void clearInput() {
    setState(() {
      _input = '';
      textEditingController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: Colors.red,
                  ),
                ),
              ),
              controller: textEditingController,
              style: TextStyle(
                fontSize: 48.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.right,
            ),
          ),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              buildButton('7'),
              buildButton('8'),
              buildButton('9'),
              buildButton('/'),
            ],
          ),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              buildButton('4'),
              buildButton('5'),
              buildButton('6'),
              buildButton('*'),
            ],
          ),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              buildButton('1'),
              buildButton('2'),
              buildButton('3'),
              buildButton('-'),
            ],
          ),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              buildButton('0'),
              buildButton('.'),
              buildButtonclear('C', textColor: Colors.red),
              buildButton('+'),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildButton(String text, {Color? textColor}) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          try {
            //يقوم بتحويل النص الى معادله رياضيه
            Parser p = Parser();
            Expression exp = p.parse(text);
            //يقوم بحساب الناتج قبل تحديد القيم
            ContextModel cm = ContextModel();
            //يقوم بحساب المعادله
            double eval = exp.evaluate(EvaluationType.REAL, cm);
            result = eval.toString();
            text = result;
          } catch (e) {
            result = 'خطأ';
          }
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Text(
          text,
          style: TextStyle(fontSize: 24.0, color: textColor),
        ),
      ),
    );
  }

  Widget buildButtonclear(String text, {Color? textColor}) {
    return ElevatedButton(
      onPressed: () => clearInput(),
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Text(
          text,
          style: TextStyle(fontSize: 24.0, color: textColor),
        ),
      ),
    );
  }
}

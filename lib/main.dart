import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator App',
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String display = '0';
  String operand = '';
  double num1 = 0;
  double num2 = 0;

  void buttonPressed(String value) {
    setState(() {
      if (value == 'C') {
        display = '0';
        operand = '';
        num1 = 0;
        num2 = 0;
      } else if (value == '+' || value == '-' || value == '*' || value == '/') {
        operand = value;
        num1 = double.tryParse(display) ?? 0;
        display = '';
      } else if (value == '=') {
        num2 = double.tryParse(display) ?? 0;
        switch (operand) {
          case '+':
            display = (num1 + num2).toString();
            break;
          case '-':
            display = (num1 - num2).toString();
            break;
          case '*':
            display = (num1 * num2).toString();
            break;
          case '/':
            display = num2 == 0 ? 'Error' : (num1 / num2).toString();
            break;
        }
      } else {
        if (display == '0') {
          display = value;
        } else {
          display += value;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Calculator')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.all(24),
              child: Text(
                display,
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Column(
            children: [
              buildButtonRow(['7', '8', '9', '/']),
              buildButtonRow(['4', '5', '6', '*']),
              buildButtonRow(['1', '2', '3', '-']),
              buildButtonRow(['C', '0', '=', '+']),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildButtonRow(List<String> buttonLabels) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: buttonLabels.map((label) {
        return Expanded(
          child: InkWell(
            onTap: () => buttonPressed(label),
            child: Container(
              margin: EdgeInsets.all(4),
              padding: EdgeInsets.symmetric(vertical: 24),
              alignment: Alignment.center,
              color: Colors.blueGrey[100],
              child: Text(
                label,
                style: TextStyle(fontSize: 32),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}

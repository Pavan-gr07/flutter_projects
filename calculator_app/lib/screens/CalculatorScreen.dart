import 'package:flutter/material.dart';

class Calculatorscreen extends StatefulWidget {
  const Calculatorscreen({super.key});

  @override
  State<Calculatorscreen> createState() => _CalculatorscreenState();
}

class _CalculatorscreenState extends State<Calculatorscreen> {
  // State variables for the calculator's logic
  String history = "";
  String output = "0";
  String _output = "0";
  double num1 = 0.0;
  double num2 = 0.0;
  String operand = "";
  bool operatorPressed = false;

  // This function handles all button presses
  buttonPressed(String buttonText) {
    if (buttonText == "C") {
      _output = "0";
      history = "";
      num1 = 0.0;
      num2 = 0.0;
      operand = "";
      operatorPressed = false;
    } else if (buttonText == "del") {
      if (_output.length > 1) {
        _output = _output.substring(0, _output.length - 1);
      } else {
        _output = "0";
      }
    } else if (buttonText == "+" ||
        buttonText == "-" ||
        buttonText == "/" ||
        buttonText == "*") {
      num1 = double.parse(output);
      operand = buttonText;
      history = output + operand;
      _output = "0";
      operatorPressed = true;
    } else if (buttonText == ".") {
      if (_output.contains(".")) {
        print("Already contains a decimal");
        return;
      } else {
        _output = _output + buttonText;
      }
    } else if (buttonText == "=") {
      if (operatorPressed) {
        num2 = double.parse(output);
        if (operand == "+") {
          _output = (num1 + num2).toString();
        }
        if (operand == "-") {
          _output = (num1 - num2).toString();
        }
        if (operand == "*") {
          _output = (num1 * num2).toString();
        }
        if (operand == "/") {
          _output = (num1 / num2).toString();
        }
        history = num1.toString() + operand + num2.toString() + " =";
        num1 = 0.0;
        num2 = 0.0;
        operand = "";
        operatorPressed = false;
      }
    } else {
      if (_output == "0") {
        _output = buttonText;
      } else {
        _output = _output + buttonText;
      }
    }

    // Update the UI
    setState(() {
      output = double.parse(_output).toStringAsFixed(2).replaceAll(RegExp(r'\.00$'),'');
    });
  }

  // This is a helper function to build the calculator buttons
  Widget buildButton(String buttonText, Color buttonColor) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(4),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor,
            padding: const EdgeInsets.all(20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          onPressed: () => buttonPressed(buttonText),
          child: Text(
            buttonText,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: const Text(
          "Calculator App",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.grey[850],
      ),
      body: Column(
        children: <Widget>[
          // Display area for the result
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  history,
                  style: const TextStyle(
                    fontSize: 24,
                    color: Colors.white70,
                  ),
                ),
                Text(
                  output,
                  style: const TextStyle(
                    fontSize: 48,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const Divider(color: Colors.grey),
          // Buttons grid
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildButton("C", Colors.grey[600]!),
                      buildButton("del", Colors.grey[600]!),
                      buildButton("/", Colors.orange[800]!),
                      buildButton("*", Colors.orange[800]!),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildButton("7", Colors.grey[800]!),
                      buildButton("8", Colors.grey[800]!),
                      buildButton("9", Colors.grey[800]!),
                      buildButton("-", Colors.orange[800]!),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildButton("4", Colors.grey[800]!),
                      buildButton("5", Colors.grey[800]!),
                      buildButton("6", Colors.grey[800]!),
                      buildButton("+", Colors.orange[800]!),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buildButton("1", Colors.grey[800]!),
                      buildButton("2", Colors.grey[800]!),
                      buildButton("3", Colors.grey[800]!),
                      buildButton("0", Colors.grey[800]!),
                    ],
                  ),
                  // This is the fixed row for the equals button
                  Row(
                    children: [
                      Expanded(
                        child: buildButton("=", Colors.orange[800]!),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

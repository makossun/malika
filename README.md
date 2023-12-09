Calculator App
This Flutter application provides a basic calculator interface for performing mathematical operations. The app is built using the Flutter framework and consists of multiple files.

Project Structure
btn.dart: Defines the Btn class containing constants for calculator buttons.
first.dart: Contains the Calca widget, which represents the main calculator interface.
main.dart: The entry point of the application that initializes and runs the Flutter app.

Clone or download the project repository.

Ensure you have Flutter installed on your development environment.

Run the app using the following command:

bash
Copy code
flutter run
Explore the calculator interface, perform calculations, and test various functionalities.

File Descriptions
btn.dart
Defines a class named Btn with constant strings representing calculator buttons.
first.dart
Contains the Calca widget, which represents the calculator UI.
Handles button taps, mathematical operations, and UI layout.
main.dart
Initializes and runs the Flutter app.
Sets the main home screen to the Calca widget.
Customization
Feel free to customize the app by modifying the code in the first.dart file. You can enhance the UI, add more features, or adapt the calculator logic to suit your preferences.

Dependencies
This project relies on Flutter and its associated packages. Ensure you have the necessary dependencies installed by running:

bash

```
import 'package:my_calc/first.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Calca(),
    );
  }
}
```

Button Constants
Numeric Digits:

Btn.num0 through Btn.num9: Represent digits 0 through 9.
Mathematical Operators:

Btn.multiply: Multiplication operator.
Btn.divide: Division operator.
Btn.plus: Addition operator.
Btn.minus: Subtraction operator.
Btn.eqaual: Equal sign for calculations.
Special Functions:

Btn.del: Delete button.
Btn.clear: Clear button.
Btn.per: Percentage button.
Btn.dot: Decimal point button.

```
import 'package:my_calc/btn.dart';
import 'package:flutter/material.dart';

class Calca extends StatefulWidget {
  const Calca({super.key});

  @override
  State<Calca> createState() => _CalcaState();
}

String value_one = '';
String operator = '';
String value_second = '';
var answear = ' ';

class _CalcaState extends State<Calca> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              reverse: true,
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      '$value_one$operator$value_second'.isEmpty
                          ? '0'
                          : '$value_one$operator$value_second',
                      style: TextStyle(
                          color: const Color.fromARGB(255, 0, 0, 0),
                          fontSize: 45),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Wrap(
              children: Btn.btnValues
                  .map((value) => SizedBox(
                      height: screenSize.height / 10,
                      width: value == Btn.num0
                          ? screenSize.width / 2
                          : screenSize.width / 4,
                      child: ButtonCustome(value)))
                  .toList(),
            ),
          )
        ],
      ),
    );
  }

  Widget ButtonCustome(value) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        clipBehavior: Clip.hardEdge,
        color: [Btn.clear, Btn.del, Btn.per, Btn.eqaual].contains(value)
            ? const Color.fromARGB(255, 99, 99, 99)
            : [Btn.plus, Btn.minus, Btn.divide, Btn.multiply].contains(value)
                ? const Color.fromARGB(255, 0, 0, 0)
                : Color.fromARGB(255, 58, 81, 228),
        shape: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent)),
        child: InkWell(
          onTap: () {
            tapping(value);
          },
          child: Center(
              child: Text(
            value,
            style: TextStyle(
                fontSize: 20,
                color: [Btn.plus, Btn.minus, Btn.divide, Btn.multiply]
                        .contains(value)
                    ? const Color.fromARGB(255, 255, 255, 255)
                    : Colors.white),
          )),
        ),
      ),
    );
  }

  void tapping(String value) {
    if (value == Btn.del) {
      delete();
      return;
    }

    if (value == Btn.clear) {
      clear();
      return;
    }
    if (value == Btn.per) {
      percentage();
      return;
    }

    if (value == Btn.eqaual) {
      equality();
      return;
    }

    join(value);
  }

  void equality() {
    if (value_one.isEmpty || value_second.isEmpty || operator.isEmpty) {
      return;
    } else if (operator.isNotEmpty && value_second.isNotEmpty) {
      double num1 = double.parse(value_one);
      double num2 = double.parse(value_second);
      double result = 0.0;
      switch (operator) {
        case Btn.plus:
          result = num1 + num2;
          break;
        case Btn.minus:
          result = num1 - num2;
          break;
        case Btn.multiply:
          result = num1 * num2;
          break;
        case Btn.divide:
          result = num1 / num2;
          break;
        default:
      }

      setState(() {
        if (value_one.endsWith('.0')) {
          value_one = value_one.substring(0, value_one.length - 2);
        }
        value_one = '$result';
        operator = '';
        value_second = '';
      });
    }
  }

  void percentage() {
    if (value_one.isNotEmpty &&
        operator.isNotEmpty &&
        value_second.isNotEmpty) {
      equality();
      return; //jwidwidiwd
    }

    if (operator.isNotEmpty) {
      return;
    }
    final number = double.parse(value_one);

    setState(() {
      value_one = '${(number / 100)}';
    });
  }

  void clear() {
    value_one = '';
    operator = '';
    value_second = '';

    setState(() {});
  }

  void delete() {
    if (value_one.isNotEmpty && operator.isEmpty) {
      value_one = value_one.substring(0, value_one.length - 1);
    } else if (value_second.isNotEmpty && operator.isNotEmpty) {
      value_second = value_second.substring(0, value_second.length - 1);
    } else if (value_one.isNotEmpty &&
        operator.isNotEmpty &&
        value_second.isEmpty) {
      operator = '';
    }
    setState(() {});
  }

  void join(String value) {
    if (value != Btn.dot && int.tryParse(value) == null) {
      operator = value;
      // if (operator.isNotEmpty && value_second.isNotEmpty) {
      //   equal();
      // }
    } else if (value_one.isEmpty || operator.isEmpty) {
      if (value == Btn.dot && value_one.contains(Btn.dot)) {
        return;
      }
      if (value == Btn.dot && value_one.isEmpty || value_one == Btn.dot) {
        value = '0.';
      }
      value_one += value;
    } else if (value_second.isEmpty || operator.isNotEmpty) {
      if (value == Btn.dot && value_second.contains(Btn.dot)) {
        return;
      }
      if (value == Btn.dot && value_second.isEmpty || value_second == Btn.dot) {
        value = '0.';
      }
      value_second += value;
    }
    setState(() {});
  }
}
```

Btn Class
You've defined a class named Btn (presumably in a separate file) that contains constant strings representing various buttons for the calculator.

Calca Widget
State Variables
value_one, operator, value_second: Strings that store the first value, operator, and second value for the calculator expression.
answear: Variable that appears to store the result of calculations.
build Method
Sets up the layout of the calculator interface using Flutter's Scaffold, Column, Expanded, and Wrap widgets.
Displays the current calculator expression at the top using a Text widget.
ButtonCustome Method
Creates a custom button widget using the Material and InkWell widgets.
The appearance and color of the button depend on its value, distinguishing between numbers, operators, and special functions.
tapping Method
Handles button taps and calls appropriate methods based on the button pressed (e.g., delete, clear, percentage, equality).
Mathematical Operations Methods
equality: Performs the mathematical operation based on the stored operator and values.
percentage: Converts the current value to a percentage.
clear: Clears all stored values and operator.
delete: Removes the last digit or operator from the current value.
join Method
Concatenates digits or decimal points to the current value based on the button pressed.
Handles scenarios where the user is inputting the first value, operator, or second value.

```

```

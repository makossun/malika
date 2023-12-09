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
            ? Color.fromARGB(255, 146, 100, 100)
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
      //   equality();
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

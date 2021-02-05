import 'package:flutter/material.dart';
import 'package:strings/strings.dart';

void main() => runApp(UnitConverter());

class UnitConverter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unit Converter',
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Unit Converter'),
          centerTitle: true,
        ),
        body: Converter(),
      ),
    );
  }
}

class Converter extends StatefulWidget {
  @override
  _ConverterState createState() => _ConverterState();
}

class _ConverterState extends State<Converter> {
  final Map<String, int> _measuresMap = {
    'meters': 0,
    'kilometers': 1,
    'grams': 2,
    'kilograms': 3,
    'feet': 4,
    'miles': 5,
    'pounds (lbs)': 6,
    'ounces': 7
  };

  final dynamic _formulas = {
    '0': [1, 0.001, 0, 0, 3.28084, 0.000621371, 0, 0],
    '1': [1000, 1, 0, 0, 3280.84, 0.621371, 0, 0],
    '2': [0, 0, 1, 0.0001, 0, 0, 0.00220462, 0.035274],
    '3': [0, 0, 1000, 1, 0, 0, 2.20462, 35.274],
    '4': [0.3048, 0.0003048, 0, 0, 1, 0.000189394, 0, 0],
    '5': [1609.34, 1.60934, 0, 0, 5280, 1, 0, 0],
    '6': [0, 0, 453.592, 0.453592, 0, 0, 1, 16],
    '7': [0, 0, 28.3495, 0.0283495, 3.28084, 0, 0.0625, 1],
  };

  double _initNumber;
  String _startValue;
  String _convertedValue;
  String _resultMsg;

  @override
  void initState() {
    _initNumber = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InputWidget(
            flex: 1,
            label: 'Value',
            childInputWidget: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Insert number to be converted",
              ),
              onChanged: (text) {
                var number = double.tryParse(text);
                if (number != null) {
                  setState(() {
                    _initNumber = number;
                  });
                }
              },
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
          ),
          InputWidget(
            flex: 1,
            label: 'From',
            childInputWidget: DropdownButton(
              items: _measuresMap.keys
                  .map(
                    (item) => DropdownMenuItem(
                      child: Text(capitalize(item)),
                      value: item,
                    ),
                  )
                  .toList(),
              onChanged: (item) {
                setState(() {
                  _startValue = item;
                });
              },
              value: _startValue,
            ),
          ),
          InputWidget(
            flex: 1,
            label: 'To',
            childInputWidget: DropdownButton(
              items: _measuresMap.keys
                  .map(
                    (item) => DropdownMenuItem(
                      child: Text(capitalize(item)),
                      value: item,
                    ),
                  )
                  .toList(),
              onChanged: (item) {
                setState(() {
                  _convertedValue = item;
                });
              },
              value: _convertedValue,
            ),
          ),
          RaisedButton(
            child: Text(
              'Convert',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              if (_startValue.isEmpty || _convertedValue.isEmpty || _initNumber == 0) {
                return;
              } else {
                convertValue(_initNumber, _startValue, _convertedValue);
              }
            },
          ),
          Expanded(
            flex: 2,
            child: Text(
              (_resultMsg == null) ? "" : _resultMsg,
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void convertValue(double value, String from, String to) {
    int _nFrom = _measuresMap[from];
    int _nTo = _measuresMap[to];

    var _multiplier = _formulas[_nFrom.toString()][_nTo];
    var result = value * _multiplier;
    if (result == 0) {
      _resultMsg = "Conversion cannot be performed";
    } else {
      _resultMsg = '${_initNumber.toString()} $_startValue = ${result.toString()} $_convertedValue';
    }
    setState(() {
      _resultMsg = _resultMsg;
    });
  }
}

class InputWidget extends StatelessWidget {
  InputWidget({this.flex, this.label, this.childInputWidget});

  final String label;
  final Widget childInputWidget;
  final int flex;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: flex,
          child: Text(
            label,
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          flex: 2,
          child: childInputWidget,
        )
      ],
    );
  }
}

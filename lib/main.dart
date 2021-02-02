import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  double _numberForm;
  final List<String> _measures = [
    'meters',
    'kilometers',
    'grams',
    'kilograms',
    'feet',
    'miles',
    'pounds (lbs)',
    'ounces',
  ];

  String _startMeasure;
  String _convertedMeasure;

  @override
  void initState() {
    _numberForm = 0;
    super.initState();
  }

  final TextStyle inputStyle = TextStyle(
    fontSize: 20,
    color: Colors.blue.shade900,
  );

  final TextStyle labelStyle = TextStyle(
    fontSize: 24,
    color: Colors.grey.shade700,
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Measures Converter',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Measures Converter'),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              Expanded(
                child: Text(
                  'Value',
                  style: labelStyle,
                ),
              ),
              Expanded(
                child: TextField(
                  onChanged: (text) {
                    var number = double.tryParse(text);
                    if (number != null) {
                      setState(() {
                        _numberForm = number;
                      });
                    }
                  },
                  decoration: InputDecoration(
                    hintText: "Please insert the measure to be converted",
                  ),
                  style: inputStyle,
                ),
              ),
              Expanded(
                child: Text(
                  'From',
                  style: labelStyle,
                ),
              ),
              Expanded(
                child: DropdownButton(
                  items: _measures
                      .map((measure) => DropdownMenuItem(
                            child: Text(
                              measure,
                              style: inputStyle,
                            ),
                            value: measure,
                          ))
                      .toList(),
                  onChanged: (measure) {
                    setState(() {
                      _startMeasure = measure;
                    });
                  },
                  value: _startMeasure,
                ),
              ),
              Expanded(
                child: Text(
                  'To',
                  style: labelStyle,
                ),
              ),
              Expanded(
                child: DropdownButton(
                  items: _measures
                      .map((measure) => DropdownMenuItem(
                            child: Text(
                              measure,
                              style: inputStyle,
                            ),
                            value: measure,
                          ))
                      .toList(),
                  onChanged: (measure) {
                    setState(() {
                      _convertedMeasure = measure;
                    });
                  },
                  value: _convertedMeasure,
                ),
              ),
              Expanded(
                child: RaisedButton(
                  child: Text(
                    'Convert',
                    style: inputStyle,
                  ),
                  onPressed: () => true,
                ),
              ),
              Expanded(
                child: Text(
                  (_numberForm == null) ? "" : _numberForm.toString(),
                  style: labelStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

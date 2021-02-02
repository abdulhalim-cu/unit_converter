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

  @override
  void initState() {
    _numberForm = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Measures Converter',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Measures Converter'),
        ),
        body: Center(
          child: Column(
            children: [
              DropdownButton(
                items: _measures
                    .map((measure) => DropdownMenuItem(
                          child: Text(measure),
                          value: measure,
                        ))
                    .toList(),
                onChanged: (_) {},
              ),
              TextField(
                onChanged: (text) {
                  var number = double.tryParse(text);
                  if (number != null) {
                    setState(() {
                      _numberForm = number;
                    });
                  }
                },
              ),
              Text((_numberForm == null) ? "" : _numberForm.toString()),
            ],
          ),
        ),
      ),
    );
  }
}

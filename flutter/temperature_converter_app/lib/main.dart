import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Temperature converter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TemperatureConverter(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class TemperatureConverter extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TemperatureConverterState();
}

class _TemperatureConverterState extends State<TemperatureConverter> {
  final double _padding = 5.0;
  final _temperatureScales = ['Celsius', 'Fahrenheit', 'Kelvin'];
  TextEditingController sourceTemperatureController = TextEditingController();
  String result = '';
  String currentSourceScale = 'Celsius';
  String currentTargetScale = 'Fahrenheit';

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.headline6;

    return Scaffold(
      appBar: AppBar(
        title: Text("Temperature Converter App"),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        padding: EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: _padding, bottom: _padding),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: sourceTemperatureController,
                      decoration: InputDecoration(
                          hintText: "e.g. 30",
                          labelText: "Source Temperature",
                          labelStyle: textStyle,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  DropdownButton<String>(
                    items: _temperatureScales
                        .map((String value) => DropdownMenuItem(
                              value: value,
                              child: Text(value),
                            ))
                        .toList(),
                    value: currentSourceScale,
                    onChanged: (String value) {
                      setState(() {
                        this.currentSourceScale = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: _padding, bottom: _padding),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      "Target temperature is " + result + " degrees",
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 16.0),
                    ),
                  ),
                  DropdownButton<String>(
                    items: _temperatureScales
                        .map((String value) => DropdownMenuItem(
                              value: value,
                              child: Text(value),
                            ))
                        .toList(),
                    value: this.currentTargetScale,
                    onChanged: (String value) {
                      setState(() {
                        this.currentTargetScale = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: _padding, bottom: _padding),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      onPressed: () {
                        setState(() {
                          result = _convert();
                        });
                      },
                      child: Text(
                        'Convert',
                        textScaleFactor: 1.5,
                      ),
                    ),
                  ),
                  Expanded(
                      child: RaisedButton(
                    color: Theme.of(context).buttonColor,
                    textColor: Theme.of(context).primaryColorDark,
                    onPressed: () {
                      setState(() {
                        _reset();
                      });
                    },
                    child: Text(
                      'Reset',
                      textScaleFactor: 1.5,
                    ),
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _convert() {
    double sourceTemperature = double.parse(sourceTemperatureController.text);
    double targetTemperature;
    if (currentSourceScale == "Celsius") {
      if (currentTargetScale == "Fahrenheit") {
        setState(() {
          targetTemperature = sourceTemperature * 1.8 + 32;
        });
      } else if (currentTargetScale == "Kelvin") {
        setState(() {
          targetTemperature = sourceTemperature + 273.15;
        });
      } else {
        setState(() { targetTemperature = sourceTemperature; });
      }
    }

    if (currentSourceScale == "Fahrenheit") {
      if (currentTargetScale == "Celsius") {
        setState(() {
          targetTemperature = (sourceTemperature - 32) / 1.8;
        });
      } else if (currentTargetScale == "Kelvin") {
        setState(() {
          targetTemperature = (sourceTemperature + 459.67) * 5 / 9;
        });
      } else {
        setState(() { targetTemperature = sourceTemperature; });
      }
    }

    if (currentSourceScale == "Kelvin") {
      if (currentTargetScale == "Celsius") {
        setState(() {
          targetTemperature = sourceTemperature - 273.15;
        });
      } else if (currentTargetScale == "Fahrenheit") {
        setState(() {
          targetTemperature = sourceTemperature * 9 / 5 - 459.67;
        });
      } else {
        setState(() { targetTemperature = sourceTemperature; });
      }
    }

    result = targetTemperature.toStringAsFixed(2);
    return result;
  }

  void _reset() {
    sourceTemperatureController.text = "";
    setState(() {
      result = "";
    });
  }
}

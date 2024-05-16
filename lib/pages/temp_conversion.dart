import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(SuhuConverterApp());
}

class SuhuConverterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Temperature Conversion',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: TempConversion(),
    );
  }
}

class TempConversion extends StatefulWidget {
  @override
  _TempConversionState createState() => _TempConversionState();
}

class _TempConversionState extends State<TempConversion> {
  double inputTemperature = 0.0;
  String selectedUnit = 'Celsius';
  List<String> units = ['Celsius', 'Fahrenheit', 'Reamur', 'Kelvin'];
  Map<String, double> results = {};

  void _convertTemperature() {
    if (inputTemperature != 0) {
      setState(() {
        results.clear();
        for (String unit in units) {
          if (unit != selectedUnit) {
            double convertedValue =
                _convertTemperatureUnit(selectedUnit, unit, inputTemperature);
            results[unit] = convertedValue;
          }
        }
      });
    }
  }

  double _convertTemperatureUnit(String from, String to, double value) {
    if (from == 'Celsius') {
      if (to == 'Fahrenheit') {
        return (value * 9 / 5) + 32;
      } else if (to == 'Reamur') {
        return value * 4 / 5;
      } else if (to == 'Kelvin') {
        return value + 273.15;
      }
    } else if (from == 'Fahrenheit') {
      if (to == 'Celsius') {
        return (value - 32) * 5 / 9;
      } else if (to == 'Reamur') {
        return (value - 32) * 4 / 9;
      } else if (to == 'Kelvin') {
        return (value - 32) * 5 / 9 + 273.15;
      }
    } else if (from == 'Reamur') {
      if (to == 'Celsius') {
        return value * 5 / 4;
      } else if (to == 'Fahrenheit') {
        return value * 9 / 4 + 32;
      } else if (to == 'Kelvin') {
        return value * 5 / 4 + 273.15;
      }
    } else if (from == 'Kelvin') {
      if (to == 'Celsius') {
        return value - 273.15;
      } else if (to == 'Fahrenheit') {
        return (value - 273.15) * 9 / 5 + 32;
      } else if (to == 'Reamur') {
        return (value - 273.15) * 4 / 5;
      }
    }
    return value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Temperature Converter')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              '👇 Input Temperature',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))
                    ],
                    onChanged: (String value) {
                      setState(() {
                        if (value.isEmpty) {
                          results.clear();
                        }
                        inputTemperature = double.tryParse(value) ?? 0.0;
                      });
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Temperature (example: 1)',
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 2.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: DropdownButton<String>(
                    value: selectedUnit,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedUnit = newValue!;
                        _convertTemperature();
                      });
                    },
                    items: units.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _convertTemperature();
              },
              child: Text('Convert'),
            ),
            SizedBox(height: 20),
            Divider(height: 20, color: Colors.grey),
            Text(
              'Conversion Results',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: results.entries.map((entry) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.25,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              entry.key,
                              style: TextStyle(fontSize: 18),
                            ),
                            SizedBox(height: 4),
                            Text(
                              entry.value.toStringAsFixed(2),
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

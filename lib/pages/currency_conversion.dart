import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';

class CurrencyConverter extends StatefulWidget {
  @override
  _CurrencyConverterState createState() => _CurrencyConverterState();
}

class _CurrencyConverterState extends State<CurrencyConverter> {
  double inputAmount = 0.0;
  String selectedCurrency = 'IDR';
  List<String> currencies = ['IDR', 'USD', 'EUR', 'GBP'];

  Map<String, double> results = {};

  void _convertCurrency() {
    if (inputAmount != 0) {
      setState(() {
        results.clear();
        for (String currency in currencies) {
          if (currency != selectedCurrency) {
            double convertedValue =
                _convertCurrencyUnit(selectedCurrency, currency, inputAmount);
            results[currency] = convertedValue;
          }
        }
      });
    }
  }

  double _convertCurrencyUnit(String from, String to, double amount) {
    // Dummy conversion rates for demonstration
    Map<String, num> conversionRates = {
      'IDR': 1,
      'USD': 0.000070,
      'EUR': 0.000059,
      'GBP': 0.000050,
    };

    if (from == 'IDR') {
      return amount * (conversionRates[to] ?? 1);
    } else {
      double inIDR = amount / (conversionRates[from] ?? 1);
      return inIDR * (conversionRates[to] ?? 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Currency Converter')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              '👇 Input Amount',
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
                        inputAmount = double.tryParse(value) ?? 0.0;
                      });
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Amount (example: 1)',
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
                    value: selectedCurrency,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedCurrency = newValue!;
                        _convertCurrency();
                      });
                    },
                    items: currencies
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Row(
                          children: [
                            Icon(
                              _getCurrencyIcon(value),
                              size: 20,
                            ),
                            SizedBox(width: 5),
                            Text(value),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _convertCurrency();
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
                            Row(
                              children: [
                                Icon(
                                  _getCurrencyIcon(entry.key),
                                  size: 20,
                                ),
                                SizedBox(width: 5),
                                Text(
                                  entry.key,
                                  style: TextStyle(fontSize: 18),
                                ),
                              ],
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

  IconData _getCurrencyIcon(String currency) {
    switch (currency) {
      case 'USD':
        return CupertinoIcons.money_dollar;
      case 'EUR':
        return CupertinoIcons.money_euro;
      case 'GBP':
        return CupertinoIcons.money_pound;
      default:
        return Icons.attach_money; // Default icon
    }
  }
}

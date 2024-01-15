import 'package:flutter/material.dart';
import 'package:tradingfolder/RatesPage.dart';

main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RatesPage(),
    );
  }
}

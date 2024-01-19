import 'package:flutter/material.dart';
import 'package:tradingfolder/pages/rates_page.dart';

main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RatesPage(),
    );
  }
}

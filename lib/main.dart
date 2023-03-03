import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_extiachine_a_cafe/pages/scanner.dart';
import 'package:flutter_extiachine_a_cafe/pages/shop.dart';
import 'package:nfc_manager/nfc_manager.dart';

void main() => runApp(Scanner());
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      theme: ThemeData(fontFamily: 'Montserrat'),
      debugShowCheckedModeBanner: false,
      home: Scanner(),
    );
  }
}



import 'package:flutter/material.dart';
import 'package:practica1/form.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shared preferences',

      home: Registro(),
    );
  }
}
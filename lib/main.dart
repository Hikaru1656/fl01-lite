import 'package:fl01_lite/screens/app.dart/ex0/ex0.dart';
import 'package:fl01_lite/screens/app.dart/ex1/ex1.dart';
import 'package:fl01_lite/screens/app.dart/ex2/ex2.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // List<dynamic> list = ['haha'];
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: Colors.blue,
      ),
      home: Ex2(),
    );
  }
}

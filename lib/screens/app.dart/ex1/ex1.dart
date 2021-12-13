import 'dart:async';

import 'package:flutter/material.dart';

class Ex1 extends StatefulWidget {
  const Ex1({Key? key}) : super(key: key);

  @override
  _Ex1State createState() => _Ex1State();
}

class _Ex1State extends State<Ex1> {
  Duration duration = Duration();

  void addTime() {
    final addSeconds = 1;

    setState(() {
      final seconds = duration.inSeconds + addSeconds;
      duration = Duration(seconds: seconds);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer.periodic(Duration(seconds: 1), (_) => addTime());
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('カウントダウンタイマー'),
      ),
      body: Container(child: buildTime()),
    );
  }

  Widget buildTime() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return Text(
      '$hours:$minutes:$seconds',
      style: TextStyle(fontSize: 50),
    );
  }
}

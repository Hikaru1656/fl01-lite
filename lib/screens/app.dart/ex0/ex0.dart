
import 'package:flutter/material.dart';

class Ex0 extends StatefulWidget {
  const Ex0({Key? key}) : super(key: key);

  @override
  _Ex0State createState() => _Ex0State();
}

class _Ex0State extends State<Ex0> {
  List<String> result = ['大凶', '凶', '吉', '小吉', '中吉', '大吉'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 100,
              backgroundColor: Colors.red,
              child: Text(result[0], style: TextStyle(fontSize: 58),),
            ),
            SizedBox(height: 20,),
            TextButton(
              child: Text('あなたの運勢は？',
                style: TextStyle(
                  fontSize: 16,
                ),
                ),
              style: ButtonStyle(
                overlayColor: MaterialStateProperty.all<Color>(Colors.white),
                foregroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed)) {
                      return Colors.white; //タップ中のテキストカラー
                    }
                    return Colors.blueAccent; //通常時のテキストカラー
                  },
                ),
              ),
              onPressed: () {
                setState(() {
                  result.shuffle();
                });
              },
              ),
          ],
        ),
      ),
    );
  }
}

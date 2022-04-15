import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'タイトル',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Appbarタイトル'),
        ),
        body: new Center(
          child: new Text(
            'ハローワールド',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: Colors.blue,
                fontSize: 32,
                decoration: TextDecoration.underline),
          ),
        ),
      ),
    );
  }
}

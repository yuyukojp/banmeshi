import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  List<String> list = [
    'https://cdn.pixabay.com/photo/2017/09/11/20/48/branches-2740419_960_720.png',
    'https://cdn.pixabay.com/photo/2017/09/11/20/48/branches-2740419_960_720.png'
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'タイトル',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('AppBarタイトル'),
        ),
        body: RotatedBox(
          quarterTurns: -1,
          child: ListWheelScrollView(
            offAxisFraction: -0.5,
            diameterRatio: 1.4,
            itemExtent: 200,
            children: [
              for (var i in List.generate(100, (i) => i))
                RotatedBox(
                  quarterTurns: 1,
                  child: Container(
                    width: 100.0,
                    height: 50.0,
                    color: Colors.blue[100],
                    child: Center(
                      child: Text(
                        "Index: $i",
                        style: TextStyle(fontSize: 30.0),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

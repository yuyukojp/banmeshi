import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),

      //MARK: - ScaffoldのAppナビゲーションバー
      home: new Scaffold(
        appBar: new AppBar(
          leading: IconButton(
            icon: Icon(Icons.add_to_photos),
            onPressed: () => {},
          ),
          title: new Text('AppBarタイトル'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              tooltip: '追加',
              onPressed: () => {},
            ),
            IconButton(
              icon: Icon(Icons.delete),
              tooltip: '削除',
              onPressed: () => {},
            ),
            IconButton(
              icon: Icon(Icons.search),
              tooltip: '検索',
              onPressed: () => {},
            ),
          ],
        ),
        body: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround, //(1)
          crossAxisAlignment: CrossAxisAlignment.stretch, //(2)
          mainAxisSize: MainAxisSize.min, //(3)
          textDirection: TextDirection.rtl, //(4)
          children: <Widget>[
            Container(
              width: 100.0,
              height: 100.0,
              color: Colors.yellow,
              alignment: Alignment.center,
              child: Text(
                '1',
                style: TextStyle(fontSize: 20),
              ),
            ),
            Container(
              width: 100.0,
              height: 100.0,
              color: Colors.deepOrange,
              alignment: Alignment.center,
              child: Text(
                '2',
                style: TextStyle(fontSize: 20),
              ),
            ),
            Container(
              width: 100.0,
              height: 100.0,
              color: Colors.green,
              alignment: Alignment.center,
              child: Text(
                '3',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

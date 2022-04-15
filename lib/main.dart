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
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Welcome to Flutter'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              RaisedButton(
                child: Text('RaisedButton'),
                color: Colors.blue,
                textColor: Colors.red,
                onPressed: () => {print('Tap button')},
              ),
              FlatButton(
                child: Text('FlatButton'),
                textColor: Colors.red,
                onPressed: () => {},
              ),
              IconButton(
                icon: Icon(
                  Icons.dehaze,
                  color: Colors.yellow,
                ),
                onPressed: () => {},
              ),
              OutlineButton(
                child: Text('OutlineButton'),
                color: Colors.blue,
                textColor: Colors.red,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                onPressed: () => {},
              ),
              // OutlineButton(
              //   child: Text('カスタムボタン'),
              //   shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(20.0)),
              // ),
              Image(
                image: AssetImage("asset/images/vip.png"),
                width: 500,
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => {},
          tooltip: '你点击的是FloatingActionButton',
        ),
      ),
    );
  }
}

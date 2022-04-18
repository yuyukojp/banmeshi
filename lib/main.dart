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

        //MARK: - SingleChildScrollView（横）
        body: new SingleChildScrollView(
          scrollDirection: Axis.horizontal, // 子ウィジェットのスクロール方向この場合row()使用
          child: Row(
            children: <Widget>[
              Text('テスト用のテキスト1'),
              Text('テスト用のテキスト1'),
              Text('テスト用のテキスト1'),
              Text('テスト用のテキスト1'),
              Text('テスト用のテキスト1'),
              Text('テスト用のテキスト1'),
              Text('テスト用のテキスト1'),
              Text('テスト用のテキスト1'),
              Text('テスト用のテキスト1'),
              Text('テスト用のテキスト1'),
              Text('テスト用のテキスト1'),
              Text('テスト用のテキスト1'),
            ],
          ),
        ),

        //MARK: - SingleChildScrollView（縦）
        // body: new SingleChildScrollView(
        //   child: Column(
        //     children: <Widget>[
        //       Text("テスト用テキスt"),
        //       Text("テスト用テキスt"),
        //       Text("テスト用テキスt"),
        //       Text("テスト用テキスt"),
        //       Text("テスト用テキスt"),
        //       Text("テスト用テキスt"),
        //       Text("テスト用テキスt"),
        //       Text("テスト用テキスt"),
        //       Text("テスト用テキスt"),
        //       Text("テスト用テキスt"),
        //       Text("テスト用テキスt"),
        //       Text("テスト用テキスt"),
        //       Text("テスト用テキスt"),
        //       Text("テスト用テキスt"),
        //       Text("テスト用テキスt"),
        //       Text("テスト用テキスt"),
        //       Text("テスト用テキスt"),
        //       Text("テスト用テキスt"),
        //       Text("テスト用テキスt"),
        //       Text("テスト用テキスt"),
        //       Text("テスト用テキスt"),
        //       Text("テスト用テキスt"),
        //       Text("テスト用テキスt"),
        //       Text("テスト用テキスt"),
        //       Text("テスト用テキスt"),
        //       Text("テスト用テキスt"),
        //       Text("テスト用テキスt"),
        //       Text("テスト用テキスt"),
        //       Text("テスト用テキスt"),
        //       Text("テスト用テキスt"),
        //       Text("テスト用テキスt"),
        //       Text("テスト用テキスt"),
        //       Text("テスト用テキスt"),
        //       Text("テスト用テキスt"),
        //       Text("テスト用テキスt"),
        //       Text("テスト用テキスt"),
        //       Text("テスト用テキスt"),
        //       Text("テスト用テキスt"),
        //       Text("テスト用テキスt"),
        //       Text("テスト用テキスt"),
        //       Text("テスト用テキスt"),
        //       Text("テスト用テキスt"),
        //       Text("テスト用テキスt"),
        //       Text("テスト用テキスt"),
        //       Text("テスト用テキスt"),
        //     ],
        //   ),
        // ),

        //MARK: - コンテナー関連
        // body: new Column(
        //   children: <Widget>[
        //     Container(
        //       width: 100.0,
        //       height: 100.0,
        //       color: Colors.blue,
        //       child: FittedBox(
        //         child: Text(
        //           'BoxFit.contain',
        //           style: TextStyle(fontSize: 32),
        //         ),
        //         fit: BoxFit.contain,
        //       ),
        //     ),
        //     Container(
        //       width: 100.0,
        //       height: 100.0,
        //       color: Colors.red,
        //       child: FittedBox(
        //         child: Text(
        //           'BoxFit.cover',
        //           style: TextStyle(fontSize: 32),
        //         ),
        //         fit: BoxFit.cover,
        //       ),
        //     ),
        //     Container(
        //       width: 100.0,
        //       height: 100.0,
        //       color: Colors.yellow,
        //       child: FittedBox(
        //         child: Text(
        //           'BoxFit.fill',
        //           style: TextStyle(fontSize: 32),
        //         ),
        //         fit: BoxFit.fill,
        //       ),
        //     ),
        //     Container(
        //       width: 100.0,
        //       height: 100.0,
        //       color: Colors.orange,
        //       child: FittedBox(
        //         child: Text(
        //           'BoxFit.scaleDown',
        //           style: TextStyle(fontSize: 32),
        //         ),
        //         fit: BoxFit.scaleDown,
        //       ),
        //     ),
        //     Container(
        //       width: 100.0,
        //       height: 100.0,
        //       color: Colors.indigo,
        //       child: FittedBox(
        //         child: Text(
        //           'BoxFit.fitHeight',
        //           style: TextStyle(fontSize: 32),
        //         ),
        //         fit: BoxFit.fitHeight,
        //       ),
        //     ),
        //     Container(
        //       width: 200.0,
        //       height: 200.0,
        //       color: Colors.pinkAccent,
        //       child: Padding(
        //         child: Text('テキスト'),
        //         padding: const EdgeInsets.all(10.0),
        //       ),
        //     ),
        //   ],
        // ),

        //MARK: - コンテナーの使用事例
        // body: Container(
        //   alignment: Alignment.centerRight,
        //   constraints: BoxConstraints.expand(width: 100, height: 80),
        //   //装飾器
        //   decoration: BoxDecoration(
        //     //枠線
        //     border: Border.all(
        //         color: Colors.yellowAccent, style: BorderStyle.solid, width: 5),
        //     //背景図
        //     image: new DecorationImage(
        //       image: AssetImage('asset/images/chair.png'),
        //     ),
        //     //円角
        //     borderRadius: BorderRadius.all(Radius.circular(30)),
        //     //陰
        //     boxShadow: [
        //       BoxShadow(
        //         color: Colors.redAccent, //陰の色
        //         offset: Offset(20, 20),
        //         blurRadius: 10, //ぼかし量
        //       ),
        //     ],
        //   ),
        //   //回転角度
        //   transform: Matrix4.rotationZ(.3),
        //   child: Text(' '),
        // ),
        //MARK: - ボタン、イメージ
        // body: Center(
        //   child: Column(
        //     children: <Widget>[
        //       RaisedButton(
        //         child: Text('RaisedButton'),
        //         color: Colors.blue,
        //         textColor: Colors.red,
        //         onPressed: () => {print('Tap button')},
        //       ),
        //       FlatButton(
        //         child: Text('FlatButton'),
        //         textColor: Colors.red,
        //         onPressed: () => {},
        //       ),
        //       IconButton(
        //         icon: Icon(
        //           Icons.dehaze,
        //           color: Colors.yellow,
        //         ),
        //         onPressed: () => {},
        //       ),
        //       OutlineButton(
        //         child: Text('OutlineButton'),
        //         color: Colors.blue,
        //         textColor: Colors.red,
        //         shape: RoundedRectangleBorder(
        //             borderRadius: BorderRadius.circular(20.0)),
        //         onPressed: () => {},
        //       ),
        //       // OutlineButton(
        //       //   child: Text('カスタムボタン'),
        //       //   shape: RoundedRectangleBorder(
        //       //       borderRadius: BorderRadius.circular(20.0)),
        //       // ),
        //       Image(
        //         image: AssetImage("asset/images/vip.png"),
        //         width: 500,
        //       ),
        //       FlutterLogo(
        //         size: 100.0,
        //         textColor: Colors.red,
        //       ),
        //     ],
        //   ),
        // ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => {},
          tooltip: '你点击的是FloatingActionButton',
        ),
      ),
    );
  }
}

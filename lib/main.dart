// import 'dart:html';

import 'package:flutter/material.dart';
import 'onePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/page1': (context) => RightPage(
              "ホーム画面",
            ),
        '/page2': (context) => RightPage(
              "画像",
            ),
        '/page3': (context) => RightPage(
              "ファイル",
            ),
        '/page4': (context) => RightPage(
              "ゲーム",
            ),
      },
      home: DrawerDemo(),
    );
  }
}

class DrawerDemo extends StatefulWidget {
  // DrawerDemo({Key key, this.title}) : super(key: key);

  // final String title;

  @override
  _DrawerDemoState createState() => _DrawerDemoState();
}

class _DrawerDemoState extends State<DrawerDemo> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('側面メニュー'),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text('name'),
              accountEmail: Text('mail'),
              currentAccountPicture: GestureDetector(
                child: new CircleAvatar(
                    // backgroundImage: AssetImage('images/header.png'),
                    ),
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            ListTile(
              title: Text('ホーム'),
              leading: Icon(Icons.description),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.pushNamed(context, '/page1');
              },
            ),
            ListTile(
              title: Text('画像'),
              leading: Icon(Icons.image),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.pushNamed(context, '/page2');
              },
            ),
            ListTile(
              title: Text('ファイル'),
              leading: Icon(Icons.insert_drive_file),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.pushNamed(context, '/page3');
              },
            ),
            ListTile(
              title: Text('ゲーム'),
              leading: Icon(Icons.videogame_asset),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.pushNamed(context, '/page4');
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Text(
          'メイン画面',
          style: TextStyle(fontSize: 50),
        ),
      ),
    );
  }
}

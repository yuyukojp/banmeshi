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
        body: CustomScrollView(
          slivers: <Widget>[
            SliverGrid(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 4,
              ),
              delegate:
                  SliverChildBuilderDelegate((BuildContext context, int index) {
                return Container(
                  alignment: Alignment.center,
                  color: Color.fromARGB(
                      255, 255 - index * 6, 255 - index * 20, index * 20),
                  child: Text('gridview$index'),
                );
              }, childCount: 10),
            ),
            SliverFixedExtentList(
              itemExtent: 50,
              delegate:
                  SliverChildBuilderDelegate((BuildContext context, int index) {
                return Container(
                  alignment: Alignment.center,
                  color: Colors.teal[100 * (index % 5)],
                  child: Text('listview$index'),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

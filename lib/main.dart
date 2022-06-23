import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _controller = TextEditingController();
  // ignore: deprecated_member_use
  final List<TodoItem> _items = [];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo App'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            child: Row(
              children: [
                _buttons('追加', 0),
                _buttons('削除ラスト', 1),
                _buttons('削除-全部', 2),
              ],
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: TextField(
                  controller: _controller,
                ),
              ),
            ],
          ),
          Container(
            child: SizedBox(
              height: 80,
            ),
          ),
          Container(
            color: Colors.deepOrange,
          ),
          Expanded(
            child: Column(
              children: _items,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buttons(
    String title,
    int type,
  ) {
    return Container(
      child: Column(
        children: [
          SizedBox(
            width: 120,
          ),
          Container(
            child: Row(
              children: [
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: Container(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  onPressed: () {
                    switch (type) {
                      case 0:
                        if (_controller.text != '') {
                          _addItem();
                        } else {
                          setState(() {});
                        }
                        break;
                      case 1:
                        _items.length == 0 ? null : _removeLast();
                        break;
                      case 2:
                        _items.length == 0 ? null : _removeAll();
                        break;
                    }
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void _addItem() {
    setState(() {
      _items.add(TodoItem(
        content: _controller.text,
      ));
      _controller.clear();
    });
  }

  void _removeLast() {
    setState(() {
      _items.removeLast();
      _controller.clear();
    });
  }

  void _removeAll() {
    setState(() {
      _items.clear();
      _controller.clear();
    });
  }
}

class TodoItem extends StatelessWidget {
  final String content;

  TodoItem({@required t, required this.content});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.expand(height: 50.0),
      child: Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.lightBlue))),
        child: Center(
          child: Text(content,
              style: TextStyle(
                fontSize: 18.0,
              )),
        ),
      ),
    );
  }
}

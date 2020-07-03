import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My first layout',
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Map<String, int>> _state = [];
  int _lastIndex = 0;
  final dataKey = new GlobalKey();

  _HomeState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Like - Dislike', textAlign: TextAlign.right,),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: EdgeInsets.only(top:0),
        child: ListView(
          children: _listBuilder(),
        ),
      ),
      floatingActionButton: _floatingButton(),
    );
  }

  Widget _floatingButton() {
    return FloatingActionButton(
        onPressed: () => {
          _addNewEntry()
        },
        tooltip: 'Floating button',
        child: Icon(
            Icons.add
        ),
        backgroundColor: Colors.deepPurple,
      );
  }

  List<Widget>_listBuilder() {
    List<Widget> _list = this._state.asMap().entries.map((MapEntry entry) {
      return _listTileBuilder(entry.key);
    }).toList();
    return _list;
  }

  Widget _listTileBuilder(int i) {
    return Card(
      child: ListTile(
        leading: RawMaterialButton(
          onPressed: () => {
            _like(i)
          },
          child: Icon(
            Icons.thumb_up,
            color: Colors.white,
          ),
          fillColor: Colors.deepPurple,
          shape: CircleBorder(),
          constraints: BoxConstraints.tight(Size(40, 40)),
        ),
        title: Text('This is line number ${this._state[i]['index']}'),
        subtitle: Text('Liked ${this._state[i]['count']} times'),
        trailing: Wrap(
          spacing: 10,
          children: <Widget>[
            RawMaterialButton(
              onPressed: () => {
                _dislike(i)
              },
              child: Icon(
                Icons.thumb_down,
                color: Colors.white,
              ),
              fillColor: Colors.redAccent,
              shape: CircleBorder(),
              constraints: BoxConstraints.tight(Size(40,40)),
            ),
            RawMaterialButton(
              onPressed: () => {
                _delete(i)
              },
              child: Icon(
                Icons.delete,
                color: Colors.white,
              ),
              fillColor: Colors.red,
              shape: CircleBorder(),
              constraints: BoxConstraints.tight(Size(40,40)),
            )
          ],
        ),
      )
    );
  }

  _like(int i) => this.setState(() => this._state[i]['count']++);

  _dislike(int i) {
    if (this._state[i]['count'] > 0) {
      this.setState(() => this._state[i]['count']--);
    } else {
      _showAlertDislike();
    }
  }

  _delete(int i) {
    this.setState(() {
      this._state.removeAt(i);
    });
  }

  _addNewEntry() {
    this.setState(() {
      this._state = this._state..add({
        'index': this._lastIndex + 1,
        'count': 0
      });
      this._lastIndex = this._lastIndex + 1;
    });
  }

  _reset() => this.setState(() => this._lastIndex = 0);

  Future _showAlertDislike() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text('Like is already at 0'),
          content: Image.asset('assets/images/pony.gif'),
        );
      }
    );
  }
}

void main () => runApp(MyApp());

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gson/gson.dart';
import 'models/Note.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Kuro's notes",
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Note> _state = [];
  int _lastIndex = 0;
  final dataKey = new GlobalKey();

  @override
  void initState() {
    super.initState();
    _loadState();
  }

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
        title: Text('This is line number ${this._state[i].index}'),
        subtitle: Text('Liked ${this._state[i].count} times'),
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

  _loadState() async {
    final prefs = await SharedPreferences.getInstance();
    final String _stateString = prefs.getString('_state');
    if (!['', null].contains(_stateString)) {
      var _state = Note.decodeNotes(_stateString);
      this.setState(() {
        this._state = _state;
      });
      var test = this._state;
    }
  }

  _saveState() async {
    final prefs = await SharedPreferences.getInstance();
    String _state = jsonEncode(this._state);
    prefs.setString('_state', _state);
  }

  _like(int i) {
    this.setState(() => this._state[i].count++);
    _saveState();
  }

  _dislike(int i) {
    if (this._state[i].count > 0) {
      this.setState(() => this._state[i].count--);
    } else {
      _showAlertDislike();
    }
    _saveState();
  }

  _delete(int i) {
    this.setState(() {
      this._state.removeAt(i);
    });
    _saveState();
  }

  _addNewEntry() {
    this.setState(() {
      this._state = this._state..add(new Note(this._lastIndex + 1, 0));
      this._lastIndex = this._lastIndex + 1;
      _saveState();
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

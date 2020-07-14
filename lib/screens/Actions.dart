import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/BottomBar.dart';
import '../configs/Consts.dart' as Consts;
import '../models/Note.dart';

class Second extends StatefulWidget {
  final Function refresh;

  Second({@required this.refresh});

  @override
  _SecondState createState() => _SecondState();
}

class _SecondState extends State<Second> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Actions', textAlign: TextAlign.right,),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: Container(
          width: 150,
          child: Column(
              children: <Widget>[
                RaisedButton(
                  onPressed: () => null,
                  child: Text('Like all'),
                  color: Colors.blueAccent,
                  textColor: Colors.white,
                ),
                RaisedButton(
                  onPressed: () => null,
                  child: Text('Dislike all'),
                  color: Colors.red,
                  textColor: Colors.white,
                ),
                RaisedButton(
                  onPressed: () => null,
                  child: Text('Reset counter'),
                  color: Colors.blueGrey,
                  textColor: Colors.white,
                ),
                RaisedButton(
                  onPressed: () => null,
                  child: Text('Delete all'),
                ),
              ],
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch
          ),
        ),
      ),
      bottomNavigationBar: BottomBar(currentIndex: Consts.SECOND),
    );
  }

  Future<List<Note>> _loadNotes() async {
    List<Note> _notes = [];
    final prefs = await SharedPreferences.getInstance();
    final String _stateString = prefs.getString('_state');
    if (!['', null].contains(_stateString)) {
      _notes = Note.decodeNotes(_stateString);
    }
    return _notes;
  }

//  _reset() async {
//    List<Note> _notes = await _loadNotes();
//    if (_notes != null) {
//      _notes = _notes.map<Note>((note) => Note(note.index, 0)).toList();
//      _saveToSharedPreferences(_notes);
//    }
//    widget.refresh();
//  }
//
//  _deleteAll() async {
//    final List<Note> _new = [];
//    _saveToSharedPreferences(_new);
//    widget.refresh();
//  }
//
//  _likeAll() async {
//    List<Note> _notes = await _loadNotes();
//    if (_notes != null) {
//      _notes = _notes.map<Note>((note) => Note(note.index, ++note.count)).toList();
//      _saveToSharedPreferences(_notes);
//    }
//    widget.refresh();
//  }
//
//  _dislikeAll() async {
//    List<Note> _notes = await _loadNotes();
//    if (_notes != null) {
//      _notes = _notes.map<Note>((note) {
//        return Note(
//          note.index,
//          note.count > 0 ? --note.count : 0
//        );
//      }).toList();
//      _saveToSharedPreferences(_notes);
//    }
//    widget.refresh();
//  }
//
//  _saveToSharedPreferences(List<Note> notes) async {
//    final prefs = await SharedPreferences.getInstance();
//    prefs.setString('_state', jsonEncode(notes));
//  }
}

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Note.dart';

class NoteProvider with ChangeNotifier {
  List<Note> notes = [];
  int lastIndex = 0;

  void load() async {
    final prefs = await SharedPreferences.getInstance();
    final String _stateString = prefs.getString('_notes');
    lastIndex = prefs.getInt('_lastIndex')??0;
    if (!['', null].contains(_stateString)) {
      notes = Note.decodeNotes(_stateString);
    }
    notifyListeners();
  }

  Future save() async {
    final prefs = await SharedPreferences.getInstance();
    String _notesString = jsonEncode(notes);
    prefs.setString('_notes', _notesString);
    prefs.setInt('_lastIndex', lastIndex);
    notifyListeners();
  }

  void like(int index) {
//    ++notes[index].count;
    save();
    notifyListeners();
  }

  void dislike(int index) {
//    --notes[index].count;
    save();
    notifyListeners();
  }

  void delete(int i) {
    notes.removeAt(i);
    save();
    notifyListeners();
  }
}
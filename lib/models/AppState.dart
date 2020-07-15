import 'dart:convert';

import 'package:test/models/Note.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppState {
  final List<Note> notes;
  final int lastIndex;
  final int currentIndex;

  AppState(this.notes, this.lastIndex, this.currentIndex);

  factory AppState.empty() => AppState(List(), 0, 0);

  Map<String, dynamic> toJson() => {
    'notes': jsonEncode(notes),
    'lastIndex': lastIndex,
    'currentIndex': currentIndex
  };

  AppState.fromJson(Map<String, dynamic> json)
    : notes = (json['notes'] as List)
      ?.map((e) => Note.fromJson(e as Map<String, int>))
      ?.toList(),
      lastIndex = json['lastIndex'] as int,
      currentIndex = json['currentIndex'] as int;

  Future saveToSharedPreference() async {
    final prefs = await SharedPreferences.getInstance();
    String _appStateString = jsonEncode(AppState);
    prefs.setString('_appState', _appStateString);
  }

  static Future loadFromSharedPreference() async {
    final prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> _appStateString = prefs.getString('_appState') as Map<String, dynamic>;
    if (!['', null].contains(_appStateString)) {
      AppState.fromJson(_appStateString);
    } else {
      AppState.empty();
    }
  }
}
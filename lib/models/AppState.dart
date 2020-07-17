import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

import 'package:test/models/Note.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'AppState.g.dart';

@JsonSerializable()
class AppState {
  final List<Note> notes;
  final int lastIndex;
  final int currentTabIndex;

  AppState({this.notes, this.lastIndex, this.currentTabIndex});

  factory AppState.empty() =>
      AppState(notes: List<Note>(), lastIndex: 0, currentTabIndex: 0);

  Map<String, dynamic> toJson() => _$AppStateToJson(this);

  factory AppState.fromJson(Map<String, dynamic> json) =>
      _$AppStateFromJson(json);

  static AppState fromJSON(dynamic json) {
    return json == null
        ? AppState.empty()
        : AppState(
            notes: Note.decodeNotes(json['notes']),
            lastIndex: json['lastIndex'] as int,
            currentTabIndex: 0);
  }

  Future saveToSharedPreference() async {
    final prefs = await SharedPreferences.getInstance();
    String _appStateString = jsonEncode(AppState);
    prefs.setString('_appState', _appStateString);
  }

  static Future loadFromSharedPreference() async {
    final prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> _appStateString =
        prefs.getString('_appState') as Map<String, dynamic>;
    if (!['', null].contains(_appStateString)) {
      AppState.fromJson(_appStateString);
    } else {
      AppState.empty();
    }
  }
}

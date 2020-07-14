import 'package:test/models/Note.dart';

class AppState {
  final List<Note> notes;

  AppState(this.notes);

  factory AppState.empty() => AppState(List());

  Map<String, dynamic> toJson() => {'notes': notes};

  AppState.fromJson(Map<String, dynamic> json)
    : notes =(json['notes'] as List)
      ?.map((e) => Note.fromJson(e as Map<String, int>))
      ?.toList();
}
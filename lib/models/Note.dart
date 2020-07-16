import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'Note.g.dart';

@JsonSerializable()
class Note {
  final int count;
  final int index;

  Note(this.index, this.count);

  factory Note.fromJson(Map<String, dynamic> json) => _$NoteFromJson(json);

  Map<String, dynamic> toJson() => _$NoteToJson(this);

  static String encodeNotes(List<Note> notes) => json.encode(notes);

  static List<Note> decodeNotes(List<dynamic> notes) {
    return notes
        .map<Note>((note) {
          return Note.fromJson(note);
        })
        .toList();
  }
}
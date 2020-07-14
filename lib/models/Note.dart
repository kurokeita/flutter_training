import 'dart:convert';

class Note {
  final int count;
  final int index;

  Note(this.index, this.count);

  Map<String, int> toJson() => {
    'count': count,
    'index': index
  };

  Note.fromJson(Map<String, int> json)
    : count = json['count'],
      index = json['index'];

  static String encodeNotes(List<Note> notes) => json.encode(notes);

  static List<Note> decodeNotes(String jsonNotes) {
    return (json.decode(jsonNotes) as List<dynamic>)
        .map<Note>((note) => Note.fromJson(note))
        .toList();
  }
}
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Note.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Note _$NoteFromJson(Map<String, dynamic> json) {
  return Note(
    json['index'] as int,
    json['count'] as int,
  );
}

Map<String, dynamic> _$NoteToJson(Note instance) => <String, dynamic>{
      'count': instance.count,
      'index': instance.index,
    };

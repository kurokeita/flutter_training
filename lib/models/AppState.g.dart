// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AppState.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppState _$AppStateFromJson(Map<String, dynamic> json) {
  return AppState(
    notes: (json['notes'] as List)
        ?.map(
            (e) => e == null ? null : Note.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    lastIndex: json['lastIndex'] as int,
    currentTabIndex: json['currentTabIndex'] as int,
    theme: json['theme'] as bool
  );
}

Map<String, dynamic> _$AppStateToJson(AppState instance) => <String, dynamic>{
      'notes': instance.notes,
      'lastIndex': instance.lastIndex,
      'currentTabIndex': instance.currentTabIndex,
      'theme': instance.theme,
    };

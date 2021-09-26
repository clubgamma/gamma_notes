// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'note_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NoteData _$NoteDataFromJson(Map<String, dynamic> json) => NoteData(
      fav: json['fav'] as bool,
      pin: json['pin'] as bool,
      note_title: json['note_title'] as String,
      note_des: json['note_des'] as String,
      edit_date: DateTime.parse(json['edit_date'] as String),
    );

Map<String, dynamic> _$NoteDataToJson(NoteData instance) => <String, dynamic>{
      'fav': instance.fav,
      'pin': instance.pin,
      'note_title': instance.note_title,
      'note_des': instance.note_des,
      'edit_date': instance.edit_date.toIso8601String(),
    };

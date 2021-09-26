import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'note_data.g.dart';

@JsonSerializable()
class NoteData extends Equatable{
  // int id;
  bool fav;
  bool pin;
  String note_title;
  String note_des;
  DateTime edit_date;

  NoteData({
    // required this.id,
    required this.fav,
    required this.pin,
    required this.note_title,
    required this.note_des,
    required this.edit_date,
  });


  factory NoteData.fromJson(Map<String, dynamic> json) => _$NoteDataFromJson(json);

  Map<String, dynamic> toJson() => _$NoteDataToJson(this);

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();




// NoteState copyWith({
//   required int id,
//   required bool fav,
//   required bool pin,
//   required String note_title,
//   required String note_des,
//   required String edit_date,
// }) {
//   return NoteState(
//       id: id,
//       fav: fav,
//       pin: pin,
//       note_title: note_title,
//       note_des: note_des,
//       edit_date: edit_date
//   );
// }
}
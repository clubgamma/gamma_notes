import 'dart:convert';
import 'dart:core';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamma_keep/NewLogic/note_data.dart';
part 'note_state.dart';

class NoteCubit extends Cubit<NoteState>{
  NoteCubit() : super(
    NoteState(noteData: [NoteData(
      // id: 0,
      note_des: "",
      note_title: "",
      pin: false,
      fav: false,
      edit_date: DateTime.now(),
    )])
  );
  
  void add_note(){
    state.noteData.add(NoteData(
        // id: state.noteData.length+1,
        fav: false,
        pin: false,
        note_title: "",
        note_des: "",
        edit_date: DateTime.now(),
    ));
    print(state.noteData.length);
    emit(NoteState(noteData: state.noteData));
  }

  void update_title(String note_title, int id){

    state.noteData[id].note_title = note_title;
    state.noteData[id].edit_date = DateTime.now();
    emit(NoteState(noteData: state.noteData));
  }

  void update_des(String note_des, int id){
    state.noteData[id].note_des = note_des;
    state.noteData[id].edit_date = DateTime.now();
    emit(NoteState(noteData: state.noteData));
  }

  void update_fav(bool note_fav, int id){
    state.noteData[id].fav = note_fav;
    emit(NoteState(noteData: state.noteData));
  }

  void update_pin(bool note_pin, int id){
    state.noteData[id].pin = note_pin;
    emit(NoteState(noteData: state.noteData));
  }



  // Hydrated Mixin
  @override
  NoteState? fromJson(Map<String, dynamic> json) {
    return NoteState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(NoteState state) {
    print("ToJsonCalled");
    return state.toMap();
  }

}
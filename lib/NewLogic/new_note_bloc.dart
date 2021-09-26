import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamma_keep/Logic/note_cubit.dart';
import 'package:gamma_keep/NewLogic/new_note_event.dart';
import 'package:gamma_keep/NewLogic/new_note_state.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'note_data.dart';

class NewNoteBloc extends HydratedBloc<NewNoteEvent, NewNoteState>{

  List<NoteData> _noteData = [];

  NewNoteBloc() : super(NewNoteInitialState());

  // @override
  // NewNoteState get initialState{
  //   return initial.state ?? NewNoteInitialState();
  // }

  @override
  NewNoteState? fromJson(Map<String, dynamic> json) {
    try{
      final noteData = NoteData.fromJson(json);
      print(noteData.note_title);
      print("Hello");
      return NewEditNoteState(noteData: noteData);
    }catch(e){
      print("error");
      return null;
    }
  }

  @override
  Map<String, dynamic>? toJson(NewNoteState state) {
    print(state);
    print("New-State");
    if(state is NewEditNoteState){
      return state.noteData.toJson();
    }else{
      return null;
    }
  }

  Stream<NewNoteState> mapEventToState(NewNoteEvent newNoteEvent) async* {

    if(newNoteEvent is NewNoteInitialState){
      yield* mapInitialEventToState();
    }

    if(newNoteEvent is NewNoteAddEvent){
      yield* mapAddNoteEventToState(newNoteEvent.title, newNoteEvent.content);
    }

    if (newNoteEvent is NewNoteEditEvent) {
      yield* mapNoteEditEventToState(
          title: newNoteEvent.title, des: newNoteEvent.des, index: newNoteEvent.index);
    }

    if(newNoteEvent is NewNoteDesEditEvent){
      yield* mapNoteDesEditEventToState(newNoteEvent.note_des, newNoteEvent.id);
    }

    if(newNoteEvent is NewNoteTitleEditEvent){
      yield* mapNoteTitleEditEventToState(newNoteEvent.note_title, newNoteEvent.id);
    }

    if(newNoteEvent is NewNoteFavEditEvent){
      yield* mapNoteFavEditEventToState(newNoteEvent.fav, newNoteEvent.id);
    }

    if(newNoteEvent is NewNotePinEditEvent){
      yield* mapNotePinEditEventToState(newNoteEvent.pin, newNoteEvent.id);
    }

    if(newNoteEvent is NewNoteDeleteEvent){
      yield* mapNoteDeleteEventToState(newNoteEvent.id);
    }
  }

  // Map Initial Event to State
  Stream<NewNoteState> mapInitialEventToState() async* {
    yield NewNoteLoadingState();
    yield NewYourNoteState(noteData: _noteData);
  }


  // Map Add Note Event to State
  Stream<NewNoteState> mapAddNoteEventToState(String title, String des) async* {
    yield NewNoteLoadingState();
    _noteData.add(
      NoteData(
          fav: false,
          pin: false,
          note_title: title,
          note_des: des,
          edit_date: DateTime.now(),
      )
    );
    yield NewYourNoteState(noteData: _noteData);
  }

  Stream<NewNoteState> mapNoteEditEventToState(
      {required String title, required String des, required int index}) async* {
    yield NewNoteLoadingState();

    _noteData[index].note_title = title;
    _noteData[index].note_des = des;

    yield NewYourNoteState(noteData: _noteData);
  }


  // Map Title Edit Event to State
  Stream<NewNoteState> mapNoteTitleEditEventToState(String title, int id) async* {
    yield NewNoteLoadingState();
    _noteData[id].note_title = title;
    _noteData[id].edit_date = DateTime.now();
    yield NewYourNoteState(noteData: _noteData);
  }


  // Map Description Edit Event to State
  Stream<NewNoteState> mapNoteDesEditEventToState(String des, int id) async* {
    yield NewNoteLoadingState();
    _noteData[id].note_des = des;
    _noteData[id].edit_date = DateTime.now();
    yield NewYourNoteState(noteData: _noteData);
  }


  // Map Fav Edit Event to State
  Stream<NewNoteState> mapNoteFavEditEventToState(bool fav, int id) async* {
    yield NewNoteLoadingState();
    _noteData[id].fav = fav;
    yield NewYourNoteState(noteData: _noteData);
  }


  // Map Pin Edit Event to State
  Stream<NewNoteState> mapNotePinEditEventToState(bool pin, int id) async* {
    yield NewNoteLoadingState();
    _noteData[id].pin = pin;
    yield NewYourNoteState(noteData: _noteData);
  }


  // Map Delete Event to State
  Stream<NewNoteState> mapNoteDeleteEventToState(int id) async*{
    yield NewNoteLoadingState();
    _noteData.removeAt(id);
    yield NewYourNoteState(noteData: _noteData);
  }
}
import 'package:equatable/equatable.dart';
import 'package:gamma_keep/Logic/note_cubit.dart';

abstract class NewNoteEvent extends Equatable{
  @override
  List<Object> get props => [];
}

// Note Initial Event
class NewNoteInitialEvent extends NewNoteEvent{}

// Note Edit Event
class NewNoteEditEvent extends NewNoteEvent {
  final String title, des;
  final int index;

  NewNoteEditEvent(
      {required this.title, required this.des, required this.index});
}


// add event
class NewNoteAddEvent extends NewNoteEvent {
  final String title, content;

  NewNoteAddEvent({required this.title, required this.content});
}


// Note Title Edit Event
class NewNoteTitleEditEvent extends NewNoteEvent{
  String note_title;
  int id;

  NewNoteTitleEditEvent({
    required this.note_title,
    required this.id
  });
}

// Note Description Edit Event
class NewNoteDesEditEvent extends NewNoteEvent{
  String note_des;
  int id;

  NewNoteDesEditEvent({
    required this.note_des,
    required this.id,
  });
}

// Note Fav Edit Event
class NewNoteFavEditEvent extends NewNoteEvent{
  bool fav;
  int id;

  NewNoteFavEditEvent({
    required this.fav,
    required this.id,
  });
}


// Note Pin Edit Event
class NewNotePinEditEvent extends NewNoteEvent{
  bool pin;
  int id;

  NewNotePinEditEvent({
    required this.pin,
    required this.id,
  });
}


// Note Delete Event
class NewNoteDeleteEvent extends NewNoteEvent{
  int id;

  NewNoteDeleteEvent({required this.id});
}

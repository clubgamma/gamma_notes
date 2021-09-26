import 'package:equatable/equatable.dart';
import 'package:gamma_keep/Logic/note_cubit.dart';

import 'note_data.dart';

abstract class NewNoteState extends Equatable{
  List<Object> get props => [];
}

// Initial State
class NewNoteInitialState extends NewNoteState{}


// Loading State
class NewNoteLoadingState extends NewNoteState{}


// Edit Note State
class NewEditNoteState extends NewNoteState{
  final NoteData noteData;
  NewEditNoteState({required this.noteData});
}

// Your Note State
class NewYourNoteState extends NewNoteState{
  final List<NoteData> noteData;
  NewYourNoteState({required this.noteData});
}

// New Note State
class NewNewNoteState extends NewNoteState{}




part of 'note_cubit.dart';

class NoteState{

  final List<NoteData> noteData;

  NoteState( {
    required this.noteData
  });




  Map<String, dynamic> toMap(){
    return {
      'note_data': noteData
    };
  }

  factory NoteState.fromMap(Map<String, dynamic> map){

    return NoteState(
        noteData: map['note_data'],
    );
  }

  String toJson() => json.encode(toMap());

  factory NoteState.fromJson(String source) =>
      NoteState.fromMap(json.decode(source));

}

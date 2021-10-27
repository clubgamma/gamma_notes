import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gamma_keep/Screens/add_notes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamma_keep/NewLogic/new_note_bloc.dart';
import 'package:gamma_keep/NewLogic/new_note_event.dart';
import '../Constants/color.dart' as colors;

class PinnedNote extends StatelessWidget {
  final state;
  final int index;

  PinnedNote({required this.state, required this.index});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      focusColor: Colors.white30,
      onTap: () async {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => AddNote(
                      id: index,
                      newNote: false,
                      note: state.noteData[index],
                    )));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        margin: const EdgeInsets.symmetric(vertical: 7.0, horizontal: 4),
        width: MediaQuery.of(context).size.width * 0.4,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white30, width: 0.5),
            borderRadius: BorderRadius.circular(15),
            color: colors.kCardColor),
        child: LayoutBuilder(
          builder: (_, constraints) {
            var blocProvider = BlocProvider.of<NewNoteBloc>(context);
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(state.noteData[index].note_title,
                        style: const TextStyle(
                            color: colors.kWhite,
                            fontSize: 18.0,
                            letterSpacing: 1.0),
                        overflow: TextOverflow.ellipsis),
                    const SizedBox(
                      height: 15.0,
                    ),
                    Text(state.noteData[index].note_des,
                        style: const TextStyle(
                            color: colors.kWhite,
                            fontSize: 15.0,
                            letterSpacing: 0.5),
                        maxLines: 9,
                        overflow: TextOverflow.ellipsis),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          blocProvider.add(NewNoteFavEditEvent(
                              fav: !state.noteData[index].fav, id: index));
                        },
                        child: Icon(
                          state.noteData[index].fav
                              ? CupertinoIcons.heart_fill
                              : CupertinoIcons.heart,
                          color: state.noteData[index].fav
                              ? Colors.redAccent
                              : Colors.white,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          blocProvider.add(NewNotePinEditEvent(
                              pin: !state.noteData[index].pin, id: index));
                        },
                        child: Icon(
                          state.noteData[index].pin
                              ? CupertinoIcons.pin_fill
                              : CupertinoIcons.pin,
                          color: state.noteData[index].pin
                              ? Colors.green
                              : Colors.white,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

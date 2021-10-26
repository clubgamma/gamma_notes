import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamma_keep/NewLogic/new_note_bloc.dart';
import 'package:gamma_keep/NewLogic/new_note_event.dart';
import 'package:gamma_keep/NewLogic/new_note_state.dart';
import 'package:gamma_keep/NewLogic/note_data.dart';
import '../Constants/color.dart' as color;
import 'package:share/share.dart';
import 'package:flutter/services.dart';

class AddNote extends StatefulWidget {
  final bool newNote;
  final NoteData note;
  final int id;
  const AddNote({Key? key, required this.note, required this.id, required this.newNote}) : super(key: key);

  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {

  bool isDeletedNote=false;//tells whether the note is intended to be deleted.

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  _showBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 200.0,
            decoration: const BoxDecoration(
              color: color.kCardColor,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      Share.share(_descriptionController.text, subject: _titleController.text);
                    },
                    child: const ListTile(
                      leading: Icon(
                        CupertinoIcons.location_fill,
                        color: color.kWhite,
                      ),
                      title: Text(
                        "Send",
                        style: TextStyle(color: color.kWhite, fontSize: 20.0),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Clipboard.setData(ClipboardData(text: _descriptionController.text)).then((_) {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Copied to your clipboard !')));
                      });
                    },
                    child: const ListTile(
                      leading: Icon(
                        CupertinoIcons.arrow_down_doc,
                        color: color.kWhite,
                      ),
                      title: Text(
                        "Copy",
                        style: TextStyle(color: color.kWhite, fontSize: 20.0),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isDeletedNote=true;
                      });
                      BlocProvider.of<NewNoteBloc>(context).add(NewNoteDeleteEvent(id: widget.id));//remove the note from list
                      //pop the bottom sheet and screen
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    child: const ListTile(
                      leading: Icon(
                        CupertinoIcons.delete,
                        color: color.kWhite,
                      ),
                      title: Text(
                        "Delete",
                        style: TextStyle(color: color.kWhite, fontSize: 20.0),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  Future<bool> _onWillPop() async {
    if (_titleController.text != "" || _descriptionController.text != "") {
      if (widget.newNote) {
        BlocProvider.of<NewNoteBloc>(context).add(NewNoteAddEvent(title: _titleController.text, content: _descriptionController.text));
      }
    }

    return true;
  }

  @override
  void initState() {
    super.initState();

    if (widget.newNote) {
      _titleController.text = "";
      _descriptionController.text = "";
    } else {
      _titleController.text = widget.note.note_title;
      _descriptionController.text = widget.note.note_des;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color.kCardColor,
      appBar: appBar(),
      body: getBody(),
      bottomSheet: footer(),
    );
  }

  AppBar appBar() {
    return AppBar(
      backgroundColor: color.kCardColor,
      elevation: 0.9,
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: BlocBuilder<NewNoteBloc, NewNoteState>(
            builder: (context, state) {
              if (state is NewYourNoteState) {
                if(isDeletedNote){//do not return new UI if the note is to be deleted

                  //The bloc Builder rebuilds UI every time there is a change in NewNoteBloc.
                  //Whenever we delete a note, the BlocBuilder rebuilds the appbar for the deleted Note id,
                  //hence this condition stops it fro rebuilding said UI if the note is deleted.
                  return const SizedBox();
                }
                else if (!widget.newNote) {
                  return GestureDetector(
                    onTap: () {
                      BlocProvider.of<NewNoteBloc>(context).add(NewNotePinEditEvent(pin: !state.noteData[widget.id].pin, id: widget.id));
                    },
                    child: Icon(
                      state.noteData[widget.id].pin ? CupertinoIcons.pin_fill : CupertinoIcons.pin,
                      color: state.noteData[widget.id].pin ? Colors.green : Colors.white,
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              } else {
                return const SizedBox();
              }
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: BlocBuilder<NewNoteBloc, NewNoteState>(
            builder: (context, state) {
              if (state is NewYourNoteState) {
                if(isDeletedNote){//do not return new UI if the note is to be deleted
                  return const SizedBox();
                }
                else if (!widget.newNote) {
                  return GestureDetector(
                    onTap: () {
                      BlocProvider.of<NewNoteBloc>(context).add(NewNoteFavEditEvent(fav: !state.noteData[widget.id].fav, id: widget.id));
                    },
                    child: Icon(
                      state.noteData[widget.id].fav ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
                      color: state.noteData[widget.id].fav ? Colors.redAccent : Colors.white,
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              } else {
                return const SizedBox();
              }
            },
          ),
        ),
      ],
    );
  }

  Widget getBody() {
    return WillPopScope(
      onWillPop: () => _onWillPop(),
      child: ListView(
        padding: const EdgeInsets.only(top: 25, right: 15, bottom: 25, left: 15),
        children: [
          TextField(
            controller: _titleController,
            cursorColor: Colors.white,
            onChanged: (data) {
              if (!widget.newNote) {
                BlocProvider.of<NewNoteBloc>(context).add(NewNoteTitleEditEvent(note_title: _titleController.text, id: widget.id));
              }
            },
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 22, color: color.kWhite.withOpacity(0.8)),
            decoration: const InputDecoration(hintText: "Title...", hintStyle: TextStyle(color: Colors.white38), border: InputBorder.none),
          ),
          TextField(
            controller: _descriptionController,
            cursorColor: Colors.white,
            onChanged: (data) {
              if (!widget.newNote) {
                BlocProvider.of<NewNoteBloc>(context).add(NewNoteDesEditEvent(note_des: _descriptionController.text, id: widget.id));
              }
            },
            maxLines: 1000,
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 17.0, height: 1.5, color: color.kWhite.withOpacity(0.8)),
            decoration: const InputDecoration(
                hintText: "Your Note goes here...", hintStyle: TextStyle(color: Colors.white38, fontSize: 17.0), border: InputBorder.none),
          ),
        ],
      ),
    );
  }

  Widget footer() {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: 50,
      decoration: BoxDecoration(
        boxShadow: [BoxShadow(color: color.kBlack.withOpacity(0.2), spreadRadius: 1, blurRadius: 3)],
        color: color.kCardColor,
      ),
      child: Padding(
        padding: const EdgeInsets.only(right: 10, left: 10, top: 10.0, bottom: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: BlocBuilder<NewNoteBloc, NewNoteState>(
                builder: (context, state) {
                  if(isDeletedNote){//do not return new UI if the note is to be deleted
                    return const SizedBox();
                  }
                  else if (state is NewYourNoteState) {
                    return Text(
                      widget.newNote
                          ? ""
                          : "Edited: ${state.noteData[widget.id].edit_date.day}/${state.noteData[widget.id].edit_date.month}/${state.noteData[widget.id].edit_date.year} ${state.noteData[widget.id].edit_date.hour}:${state.noteData[widget.id].edit_date.minute}",
                      style: TextStyle(fontSize: 17, color: color.kWhite.withOpacity(0.5)),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
            IconButton(
              onPressed: () {
                _showBottomSheet(context);
              },
              icon: Icon(
                CupertinoIcons.shift_fill,
                size: 22,
                color: color.kWhite.withOpacity(0.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

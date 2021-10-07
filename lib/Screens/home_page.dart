import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:gamma_keep/Logic/note_cubit.dart';
import 'package:gamma_keep/NewLogic/new_note_bloc.dart';
import 'package:gamma_keep/NewLogic/new_note_event.dart';
// import 'package:gamma_keep/NewLogic/new_note_event.dart';
import 'package:gamma_keep/NewLogic/new_note_state.dart';
import 'package:gamma_keep/NewLogic/note_data.dart';
import 'package:gamma_keep/Screens/add_notes.dart';
import 'package:gamma_keep/Screens/side_bar.dart';
import '../Constants/color.dart' as colors;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.kBgColor,
      key: _drawerKey,
      drawer: const SideBar(),
      appBar: AppBar(
        backgroundColor: colors.kBgColor,
        elevation: 0.9,
        leading: GestureDetector(
          onTap: () {
            _drawerKey.currentState?.openDrawer();
          },
          child: const Icon(
            CupertinoIcons.bars,
            size: 27.0,
          ),
        ),
        title: const Text("Gamma Notes"),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.tealAccent,
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
            return AddNote(
              newNote: true,
              id: -1,
              note: NoteData(
                note_title: "",
                note_des: "",
                fav: false,
                pin: false,
                edit_date: DateTime.now(),
              ),
            );
          }));
        },
        child: const Icon(
          CupertinoIcons.add,
          color: colors.kBgColor,
        ),
      ),
      body: buildNotes(),
    );
  }

  Widget buildNotes() {
    return BlocBuilder<NewNoteBloc, NewNoteState>(
      builder: (context, state) {
        if (kDebugMode) {
          print(state);
          print("=========");
        }
        if (state is NewNoteInitialState) {
          return Container();
        }
        if (state is NewYourNoteState) {
          return GridView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: state.noteData.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
            ),
            itemBuilder: (BuildContext context, int index) {
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
                      border: Border.all(color: Colors.white30, width: 0.5), borderRadius: BorderRadius.circular(15), color: colors.kCardColor),
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
                                  style: const TextStyle(color: colors.kWhite, fontSize: 18.0, letterSpacing: 1.0), overflow: TextOverflow.ellipsis),
                              const SizedBox(
                                height: 15.0,
                              ),
                              Text(state.noteData[index].note_des,
                                  style: const TextStyle(color: colors.kWhite, fontSize: 15.0, letterSpacing: 0.5),
                                  maxLines: 9,
                                  overflow: TextOverflow.ellipsis),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [


                              GestureDetector(
                                onTap: () {
                                  blocProvider.add(NewNoteFavEditEvent(fav: !state.noteData[index].fav, id: index));
                                },
                                child: Icon(
                                  state.noteData[index].fav ? CupertinoIcons.heart_fill : CupertinoIcons.heart,
                                  color: state.noteData[index].fav ? Colors.redAccent : Colors.white,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  blocProvider.add(NewNotePinEditEvent(pin: !state.noteData[index].pin, id: index));
                                },
                                child: Icon(
                                  state.noteData[index].pin ? CupertinoIcons.pin_fill : CupertinoIcons.pin,
                                  color: state.noteData[index].pin ? Colors.green : Colors.white,
                                ),
                              ),
                            ],
                          )
                        ],
                      );
                    },
                  ),
                ),
              );
            },
          );
        } else {
          return Container();
        }
      },
    );
  }
}

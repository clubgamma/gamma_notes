import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gamma_keep/NewLogic/new_note_bloc.dart';
import 'package:gamma_keep/NewLogic/new_note_state.dart';
import 'package:gamma_keep/Screens/add_notes.dart';
import 'package:gamma_keep/Screens/pinned_note.dart';
import 'package:gamma_keep/Screens/side_bar.dart';
import '../Constants/color.dart' as colors;

class PinnedNotes extends StatefulWidget {
  const PinnedNotes({Key? key}) : super(key: key);

  @override
  _PinnedNotesState createState() => _PinnedNotesState();
}

class _PinnedNotesState extends State<PinnedNotes> {
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  bool _isGrid = true;

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
        actions: [
          InkWell(
            onTap: () {
              setState(() {
                _isGrid ? _isGrid = false : _isGrid = true;
              });
            },
            splashColor: colors.kCardColor,
            borderRadius: BorderRadius.circular(20),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    _isGrid ? 'GridView' : 'ListView',
                    style: TextStyle(fontSize: 16),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Icon(
                      _isGrid
                          ? Icons.list_alt_outlined
                          : Icons.grid_view_outlined,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
        title: const Text("Pinned Notes"),
      ),
      body: buildNotes(),
    );
  }

  Widget buildNotes() {
    return BlocBuilder<NewNoteBloc, NewNoteState>(
      builder: (context, state) {
        print(state);
        print("=========");
        if (state is NewNoteInitialState) {
          return Container();
        }
        if (state is NewYourNoteState) {
          return Padding(
            padding: const EdgeInsets.all(10),
            child: PinnedNotesView(state: state, isGrid: _isGrid),
          );
        } else {
          return Container();
        }
      },
    );
  }
}

class PinnedNotesView extends StatelessWidget {
  final state;
  final bool isGrid;

  PinnedNotesView({required this.state, required this.isGrid});

  @override
  Widget build(BuildContext context) {
    return isGrid
        ? GridView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: state.noteData.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
            ),
            itemBuilder: (BuildContext context, int index) {
              if (state.noteData[index].pin) {
                return PinnedNote(
                  state: state,
                  index: index,
                );
              } else {
                return const SizedBox.shrink();
              }
            })
        : ListView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: state.noteData.length,
            itemBuilder: (BuildContext context, int index) {
              if (state.noteData[index].pin) {
                return PinnedNote(state: state, index: index);
              } else {
                return const SizedBox.shrink();
              }
            },
          );
  }
}

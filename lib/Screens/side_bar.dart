import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gamma_keep/Constants/color.dart';
import 'package:gamma_keep/Screens/fav_notes.dart';
import 'package:gamma_keep/Screens/home_page.dart';
import 'package:gamma_keep/Screens/pin_notes.dart';
import '../Constants/color.dart' as color;

class SideBar extends StatefulWidget {
  const SideBar({Key? key}) : super(key: key);

  @override
  _SideBarState createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
//      backgroundColor: kBgColor,
      child: Container(
        color: kBgColor,
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(top: 40.0, left: 30.0, bottom: 20.0),
              child: Row(
                children: const [
                  Text(
                    "Gamma Notes",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 23,
                        color: color.kWhite),
                  ),
                ],
              ),
            ),
            const Divider(
              height: 1.0,
              color: Colors.white24,
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomePage()));
              },
              child: const ListTile(
                leading: Icon(
                  CupertinoIcons.home,
                  color: color.kWhite,
                ),
                title: Text(
                  "Home",
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PinnedNotes()));
              },
              child: const ListTile(
                leading: Icon(
                  CupertinoIcons.pin,
                  color: color.kWhite,
                ),
                title: Text(
                  "Pinned",
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FavoriteNotesScreen()));
              },
              child: const ListTile(
                leading: Icon(
                  CupertinoIcons.heart,
                  color: color.kWhite,
                ),
                title: Text(
                  "Favourites",
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

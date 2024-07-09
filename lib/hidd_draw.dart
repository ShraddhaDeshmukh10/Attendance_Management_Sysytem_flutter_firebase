import 'package:firebase_03/add_att.dart';
import 'package:firebase_03/add_attendance.dart';
import 'package:firebase_03/search_stu.dart';
import 'package:firebase_03/student_log.dart';
import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';

class HiddenDrawer01 extends StatefulWidget {
  const HiddenDrawer01({Key? key}) : super(key: key);

  @override
  State<HiddenDrawer01> createState() => _HiddenDrawer01State();
}

class _HiddenDrawer01State extends State<HiddenDrawer01> {
  late List<ScreenHiddenDrawer> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: "Add Student Addmission",
          baseStyle: const TextStyle(),
          selectedStyle: const TextStyle(),
        ),
        attend01(),
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: "Add Student attendance",
          baseStyle: const TextStyle(),
          selectedStyle: const TextStyle(),
        ),
        search_002(),
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: "Search Student",
          baseStyle: const TextStyle(),
          selectedStyle: const TextStyle(),
        ),
        attend_search01(),
      ),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: "Logout",
          baseStyle: const TextStyle(),
          selectedStyle: const TextStyle(),
        ),
        signup01(),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return HiddenDrawerMenu(
      screens: _pages,
      backgroundColorMenu: Colors.greenAccent,
    );
  }
}

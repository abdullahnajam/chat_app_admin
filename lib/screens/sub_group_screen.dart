import 'package:chat_app_admin/components/groups/groups.dart';
import 'package:chat_app_admin/components/users/users.dart';
import 'package:flutter/material.dart';
import '../components/sub_groups/sub_groups.dart';
import '../navigator/side_menu.dart';
import '../utils/responsive.dart';

class SubGroupScreen extends StatelessWidget {
  int index;

  SubGroupScreen(this.index);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: SideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // We want this side menu only for large screen
            if (Responsive.isDesktop(context))
              Expanded(
                // default flex = 1
                // and it takes 1/6 part of the screen
                child: SideMenu(),
              ),
            Expanded(
              // It takes 5/6 part of the screen
              flex: 5,
              child: SubGroups(_scaffoldKey,index),
            ),
          ],
        ),
      ),
    );
  }
}
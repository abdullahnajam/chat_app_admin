import 'package:chat_app_admin/components/occupations/occupations.dart';
import 'package:chat_app_admin/components/reports/reports.dart';
import 'package:chat_app_admin/components/users/users.dart';
import 'package:flutter/material.dart';
import '../components/abuse/abuse.dart';
import '../navigator/side_menu.dart';
import '../utils/responsive.dart';

class AbuseScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const SideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // We want this side menu only for large screen
            if (Responsive.isDesktop(context))
              const Expanded(

                child: SideMenu(),
              ),
            Expanded(
              // It takes 5/6 part of the screen
              flex: 5,
              child: Abuse(_scaffoldKey),
            ),
          ],
        ),
      ),
    );
  }
}

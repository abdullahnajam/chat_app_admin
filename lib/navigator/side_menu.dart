import 'package:chat_app_admin/screens/add_res_screen.dart';
import 'package:chat_app_admin/screens/country_screen.dart';
import 'package:chat_app_admin/screens/group_screen.dart';
import 'package:chat_app_admin/screens/job_description_screen.dart';
import 'package:chat_app_admin/screens/location_screen.dart';
import 'package:chat_app_admin/screens/occupation_screen.dart';
import 'package:chat_app_admin/screens/res_type_screen.dart';
import 'package:chat_app_admin/screens/sub_group_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../screens/invited_users_screen.dart';
import '../screens/users_screen.dart';
import '../utils/constants.dart';


class SideMenu extends StatefulWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  _SideMenuState createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: primaryColor,
        child: Container(
          color: primaryColor,
          child:ListView(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.white
                ),
                child: Image.asset("assets/images/logo.png"),
              ),

              ExpansionTile(
                collapsedIconColor: Colors.white,
                collapsedTextColor: Colors.white,

                leading: Icon(Icons.person,color: Colors.white),
                title: Text(
                  "Users",
                  style: TextStyle(color: Colors.white),
                ),
                children: <Widget>[
                  ListTile(
                    onTap: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => UserScreen()));

                    },
                    leading: Icon(Icons.person,color: Colors.white),
                    title: Text(
                      "Users",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => InvitedUserScreen()));

                    },
                    leading: Icon(Icons.person_add_alt_1,color: Colors.white),
                    title: Text(
                      "Invited Users",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),

              ExpansionTile(
                collapsedIconColor: Colors.white,
                collapsedTextColor: Colors.white,

                leading: Icon(Icons.people,color: Colors.white),
                title: Text(
                  "Groups",
                  style: TextStyle(color: Colors.white),
                ),
                children: <Widget>[
                  ListTile(
                    onTap: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => GroupScreen()));

                    },
                    leading: Icon(Icons.people,color: Colors.white),
                    title: Text(
                      "Main Group",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => SubGroupScreen(1)));

                    },
                    leading: Icon(Icons.people,color: Colors.white),
                    title: Text(
                      "Sub Group 1",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => SubGroupScreen(2)));

                    },
                    leading: Icon(Icons.people,color: Colors.white),
                    title: Text(
                      "Sub Group 2",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => SubGroupScreen(3)));

                    },
                    leading: Icon(Icons.people,color: Colors.white),
                    title: Text(
                      "Sub Group 3",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => SubGroupScreen(4)));

                    },
                    leading: Icon(Icons.people,color: Colors.white),
                    title: Text(
                      "Sub Group 4",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              ListTile(
                onTap: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => OccupationScreen()));

                },
                leading: Icon(Icons.wallet_travel,color: Colors.white),
                title: Text(
                  "Occupations",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => AdditionalResponsibilityScreen()));

                },
                leading: Icon(Icons.assignment_ind,color: Colors.white),
                title: Text(
                  "Additional Responsibility",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => LocationScreen()));

                },
                leading: Icon(Icons.location_on_sharp,color: Colors.white),
                title: Text(
                  "Location",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => JobDescriptionScreen()));

                },
                leading: Icon(Icons.assignment,color: Colors.white),
                title: Text(
                  "Job Description",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => CountryScreen()));

                },
                leading: Icon(Icons.map,color: Colors.white),
                title: Text(
                  "Country",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => ResTypeScreen()));

                },
                leading: Icon(Icons.merge_type,color: Colors.white),
                title: Text(
                  "Responsibility Type",
                  style: TextStyle(color: Colors.white),
                ),
              ),






            ],
          ),
        )
    );
  }
}


class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      leading: Icon(Icons.person),
      title: Text(
        title,
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}


import 'package:chat_app_admin/components/reports/report_list.dart';
import 'package:chat_app_admin/model/user_model.dart';
import 'package:chat_app_admin/utils/custom_dialogs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import '../../utils/constants.dart';
import '../../utils/header.dart';
import '../../utils/responsive.dart';
class Reports extends StatefulWidget {

  GlobalKey<ScaffoldState> _scaffoldKey;

  Reports(this._scaffoldKey);

  @override
  _ReportsState createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Header("Reports",widget._scaffoldKey),
            const SizedBox(height: defaultPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "",
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          Expanded(
                            child: TypeAheadField(
                              textFieldConfiguration: TextFieldConfiguration(
                                decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  hintText: 'Search user by name',
                                  fillColor: Colors.white,
                                  filled: true,

                                ),
                              ),
                              noItemsFoundBuilder: (context) {
                                return ListTile(
                                  leading: Icon(Icons.error),
                                  title: Text("No Group Found"),
                                );
                              },
                              suggestionsCallback: (pattern) async {

                                List<UserModel> search=[];
                                await FirebaseFirestore.instance
                                    .collection('users')
                                    .get()
                                    .then((QuerySnapshot querySnapshot) {
                                  querySnapshot.docs.forEach((doc) {
                                    Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
                                    UserModel model=UserModel.fromMap(data, doc.reference.id);
                                    if ("${model.name}".contains(pattern))
                                      search.add(model);
                                  });
                                });

                                return search;
                              },
                              itemBuilder: (context, UserModel suggestion) {
                                return ListTile(
                                  leading: Icon(Icons.people),
                                  title: Text("${suggestion.name}"),
                                  subtitle: Text(suggestion.email!),
                                );
                              },
                              onSuggestionSelected: (UserModel suggestion) {
                                CustomDialogs.showUserDataDialog(context, suggestion);

                              },
                            ),
                          )

                        ],
                      ),

                      const SizedBox(height: defaultPadding),
                      const ReportList(),
                      if (Responsive.isMobile(context))
                        const SizedBox(height: defaultPadding),
                    ],
                  ),
                ),
                if (!Responsive.isMobile(context))
                  const SizedBox(width: defaultPadding),


              ],
            )
          ],
        ),
      ),
    );
  }
}

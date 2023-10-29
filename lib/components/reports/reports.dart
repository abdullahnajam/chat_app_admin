
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

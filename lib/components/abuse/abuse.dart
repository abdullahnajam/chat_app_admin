
import 'package:chat_app_admin/components/abuse/abuse_report_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../utils/constants.dart';
import '../../utils/header.dart';
import '../../utils/responsive.dart';
class Abuse extends StatefulWidget {

  GlobalKey<ScaffoldState> _scaffoldKey;

  Abuse(this._scaffoldKey);

  @override
  _AbuseState createState() => _AbuseState();
}

class _AbuseState extends State<Abuse> {



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Header("Abuse",widget._scaffoldKey),
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
                        ],
                      ),

                      const SizedBox(height: defaultPadding),
                      const AbuseReportList(),
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

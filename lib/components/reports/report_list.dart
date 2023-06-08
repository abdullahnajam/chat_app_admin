
import 'package:chat_app_admin/model/user_model.dart';
import 'package:chat_app_admin/utils/custom_dialogs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../utils/constants.dart';
import '../../utils/responsive.dart';
class ReportList extends StatefulWidget {
  const ReportList({Key? key}) : super(key: key);

  @override
  _ReportListState createState() => _ReportListState();
}


class _ReportListState extends State<ReportList> {


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: SizedBox(
        height: MediaQuery.of(context).size.height*0.8,
        width: MediaQuery.of(context).size.width,
        child:StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('users').orderBy('createdAt',descending: true).snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                margin: EdgeInsets.all(30),
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.data!.size==0){
              return Container(
                width: double.infinity,
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.all(80),
                alignment: Alignment.center,
                child: Text("No data found"),
              );
            }
            print("size ${snapshot.data!.size}");
            return  DataTable2(

                showCheckboxColumn: false,
                columnSpacing: defaultPadding,
                minWidth: 600,
                columns: const [

                  DataColumn(
                    label: Text("Name"),
                  ),
                  DataColumn(
                    label: Text("Email"),
                  ),
                  DataColumn(
                    label: Text("Referred By"),
                  ),
                  DataColumn(
                    label: Text("Actions"),
                  ),

                ],
                rows:  _buildList(context, snapshot.data!.docs)
            );
          },
        ),
      )
    );
  }

  List<DataRow> _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return  snapshot.map((data) => _buildListItem(context, data)).toList();
  }

  DataRow _buildListItem(BuildContext context, DocumentSnapshot data) {
    final model = UserModel.fromSnapshot(data);
    return DataRow(
        cells: [
          DataCell(Text(model.name)),
          DataCell(Text(model.email)),
          DataCell(
            model.referred_by=='none'?
            Text('None'):
            FutureBuilder<UserModel>(
                future: getUserData(model.referred_by),
                builder: (context, AsyncSnapshot<UserModel> usersnap) {
                  if (usersnap.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CupertinoActivityIndicator(),
                    );
                  }
                  else {
                    if (usersnap.hasError) {
                      print("error ${usersnap.error}");
                      return Center(
                        child: Text("something went wrong : ${usersnap.error}"),
                      );
                    }



                    else {
                      return Text(usersnap.data!.name);

                    }
                  }
                }
            ),
          ),
          DataCell(
            ElevatedButton(
              onPressed: (){
                CustomDialogs.showUserDataDialog(context, model);
              },
              child: const Text('View Details'),
            )
          ),

        ]);
  }

  static Future<UserModel> getUserData(String id)async{
    UserModel? request;
    await FirebaseFirestore.instance.collection('users')
        .doc(id)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        Map<String, dynamic> data = documentSnapshot.data()! as Map<String, dynamic>;
        request= UserModel.fromMap(data, documentSnapshot.reference.id);
      }
      else{
        print("no user found $id");
      }
    });
    return request!;
  }





}




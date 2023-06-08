import 'package:chat_app_admin/model/abuse_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../model/user_model.dart';
import '../../utils/constants.dart';
class AbuseReportList extends StatefulWidget {
  const AbuseReportList({Key? key}) : super(key: key);

  @override
  _AbuseReportListState createState() => _AbuseReportListState();
}


class _AbuseReportListState extends State<AbuseReportList> {


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
          stream: FirebaseFirestore.instance.collection('reports').orderBy('createdAt',descending: true).snapshots(),
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
                    label: Text("Reporter"),
                  ),
                  DataColumn(
                    label: Text("Abuser"),
                  ),
                  DataColumn(
                    label: Text("Topic"),
                  ),
                  DataColumn(
                    label: Text("Report"),
                  ),
                  DataColumn(
                    label: Text("Time/Date"),
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
    final model = AbuseModel.fromSnapshot(data);
    return DataRow(
        cells: [
          DataCell(
            FutureBuilder<UserModel>(
                future: getUserData(model.reporter_id),
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
            FutureBuilder<UserModel>(
                future: getUserData(model.abuser_id),
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
            Text(model.topic)
          ),
          DataCell(
              Text(model.report)
          ),
          DataCell(
              Text(dfampm.format(DateTime.fromMillisecondsSinceEpoch(model.createdAt)))
          ),
          DataCell(
              FutureBuilder<UserModel>(
                  future: getUserData(model.abuser_id),
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
                        return usersnap.data!.status!='Blocked'?
                        ElevatedButton(
                          onPressed: ()async{
                            print(' id ${model.id}.');
                            await FirebaseFirestore.instance.collection('users').doc(model.abuser_id).update({
                              "status":'Blocked',
                            });
                            setState(() {

                            });

                          },
                          child: const Text('Block User'),
                        )
                            :
                        ElevatedButton(
                          onPressed: ()async{
                            print(' id ${model.abuser_id}.');
                            await FirebaseFirestore.instance.collection('users').doc(model.abuser_id).update({
                              "status":'Active',
                            });
                            setState(() {

                            });
                          },
                          child: const Text('Unblock User'),
                        );

                      }
                    }
                  }
              ),


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




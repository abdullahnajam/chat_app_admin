
import 'package:chat_app_admin/model/user_model.dart';
import 'package:chat_app_admin/utils/custom_dialogs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../data/firebase_api.dart';
import '../../utils/constants.dart';
import '../../utils/responsive.dart';
class ReportList extends StatefulWidget {
  const ReportList({Key? key}) : super(key: key);

  @override
  _ReportListState createState() => _ReportListState();
}


class _ReportListState extends State<ReportList> {

  String filter='Name';
  String query='';
  var _controller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height*0.8,
        width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex:3,
                child: InkWell(
                  onTap: ()async{


                  },
                  child: Container(
                    height: 50,


                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(7),
                          bottomLeft: Radius.circular(7),
                        )
                    ),
                    alignment: Alignment.center,
                    child: DropdownButton<String>(
                      value: filter,
                      isExpanded: false,
                      icon: const Icon(Icons.arrow_drop_down),
                      elevation: 16,
                      style: const TextStyle(color: Colors.black),
                      underline: Container(

                      ),
                      onChanged: (String? value) {
                        setState(() {
                          filter=value!;
                        });
                      },
                      items: ['Name','Email','Mobile','City','Country','Main Group','Sub Group 1','Sub Group 2','Sub Group 3','Sub Group 4'].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex:7,
                child: TextFormField(
                  controller: _controller,

                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  onChanged: (value){
                    setState(() {
                      query=value;
                    });
                  },

                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(15),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(7),
                        bottomRight: Radius.circular(7),
                      ),
                      borderSide: BorderSide(
                        color: Colors.grey.shade300,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(7),
                        bottomRight: Radius.circular(7),
                      ),
                      borderSide: BorderSide(
                          color: Colors.grey.shade300,
                          width: 0.5
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(7),
                        bottomRight: Radius.circular(7),
                      ),
                      borderSide: BorderSide(
                        color: Colors.grey.shade300,
                        width: 0.5,
                      ),
                    ),
                    hintText: 'Search',
                    suffixIcon: IconButton(
                      onPressed: (){
                        /*setState(() {
                          query=_controller.text;
                        });*/
                      },
                      icon: const Icon(Icons.search,color: primaryColor,),
                    ),
                    // If  you are using latest version of flutter then lable text and hint text shown like this
                    // if you r using flutter less then 1.20.* then maybe this is not working properly
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                ),
              ),

            ],
          ),
          Expanded(
            child: FutureBuilder<List<UserModel>>(
                future: FirebaseApi.getAllUsersFiltered(filter,query),
                builder: (context, AsyncSnapshot<List<UserModel>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                        child: CircularProgressIndicator()
                    );
                  }
                  else {
                    if (snapshot.hasError) {
                      print("error ${snapshot.error}");
                      return const Center(
                        child: Text("Something went wrong"),
                      );
                    }
                    else if (snapshot.data!.length==0) {
                      print("error ${snapshot.error}");
                      return const Center(
                        child: Text("No Data"),
                      );
                    }

                    else {


                      return DataTable2(

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
                          rows:  List<DataRow>.generate(snapshot.data!.length, (index){
                            return DataRow(
                                cells: [


                                  DataCell(Text(snapshot.data![index].name)),
                                  DataCell(Text(snapshot.data![index].email)),

                                  DataCell(
                                    snapshot.data![index].referred_by=='none'?
                                    Text('None'):
                                    FutureBuilder<UserModel>(
                                        future: getUserData(snapshot.data![index].referred_by),
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
                                          CustomDialogs.showUserDataDialog(context, snapshot.data![index]);
                                        },
                                        child: const Text('View Details'),
                                      )
                                  ),

                                ]);
                          })
                      );
                    }
                  }
                }
            ),
          ),
          /*SizedBox(
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
          ),*/
        ],
      )
    );
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




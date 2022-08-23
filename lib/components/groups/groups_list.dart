import 'dart:html';
import 'dart:ui' as UI;
import 'package:chat_app_admin/model/main_group_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
import '../../utils/constants.dart';
import '../../utils/responsive.dart';
class GroupList extends StatefulWidget {
  const GroupList({Key? key}) : super(key: key);

  @override
  _GroupListState createState() => _GroupListState();
}


class _GroupListState extends State<GroupList> {

  var _nameController=TextEditingController();
  var _codeController=TextEditingController();

  Future<void> _showEditDialog(MainGroupModel model) async {






    final _formKey = GlobalKey<FormState>();
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context,setState){
            _nameController.text=model.name;
            _codeController.text=model.code;
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: const BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
              insetAnimationDuration: const Duration(seconds: 1),
              insetAnimationCurve: Curves.fastOutSlowIn,
              elevation: 2,

              child: Container(
                height: MediaQuery.of(context).size.height*0.35,
                width: Responsive.isMobile(context)?MediaQuery.of(context).size.width*0.9:MediaQuery.of(context).size.width*0.7,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            )
                        ),
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                padding: EdgeInsets.all(10),
                                child: Text("EDIT GROUP",textAlign: TextAlign.center,style: Theme.of(context).textTheme.headline5!.apply(color: Colors.white),),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                padding: EdgeInsets.only(top: 5,right: 10,bottom: 5),
                                child: InkWell(
                                  child: CircleAvatar(
                                    radius: 20,
                                    backgroundColor: Colors.white,
                                    child: Icon(Icons.close,color: primaryColor,size: 20,),
                                  ),
                                  onTap: ()=>Navigator.pop(context),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView(
                          padding: EdgeInsets.all(10),
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Name",
                                  style: Theme.of(context).textTheme.bodyText1!.apply(color: Colors.black),
                                ),
                                TextFormField(
                                  controller: _nameController,
                                  style: TextStyle(color: Colors.black),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(15),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(7.0),
                                      borderSide: BorderSide(
                                        color: primaryColor,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(7.0),
                                      borderSide: BorderSide(
                                          color: primaryColor,
                                          width: 0.5
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(7.0),
                                      borderSide: BorderSide(
                                        color: primaryColor,
                                        width: 0.5,
                                      ),
                                    ),
                                    hintText: "",
                                    floatingLabelBehavior: FloatingLabelBehavior.always,
                                  ),
                                ),

                              ],
                            ),
                            SizedBox(height: 20,),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Code",
                                  style: Theme.of(context).textTheme.bodyText1!.apply(color: Colors.black),
                                ),
                                TextFormField(
                                  controller: _codeController,
                                  style: TextStyle(color: Colors.black),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(15),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(7.0),
                                      borderSide: BorderSide(
                                        color: primaryColor,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(7.0),
                                      borderSide: BorderSide(
                                          color: primaryColor,
                                          width: 0.5
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(7.0),
                                      borderSide: BorderSide(
                                        color: primaryColor,
                                        width: 0.5,
                                      ),
                                    ),
                                    hintText: "",
                                    floatingLabelBehavior: FloatingLabelBehavior.always,
                                  ),
                                ),

                              ],
                            ),

                            SizedBox(height: 10,),
                            InkWell(
                              onTap: ()async{
                                final ProgressDialog pr = ProgressDialog(context: context);
                                pr.show(max: 100, msg: "Please wait");
                                await FirebaseFirestore.instance.collection('main_group').doc(model.id).update({
                                  "code":_codeController.text,
                                  "name":_nameController.text,

                                }).then((value) {
                                  pr.close();
                                  Navigator.pop(context);
                                }).onError((error, stackTrace){
                                  pr.close();
                                  CoolAlert.show(
                                    context: context,
                                    type: CoolAlertType.error,
                                    text: error.toString(),
                                  );
                                });
                              },
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  color: primaryColor,
                                ),
                                alignment: Alignment.center,
                                child: Text("Update Group",style: Theme.of(context).textTheme.button!.apply(color: Colors.white),),
                              ),
                            )
                          ],
                        ),
                      )



                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Future<void> _showSubGroupsDialog(MainGroupModel model) async {


    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context,setState){

            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: const BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
              insetAnimationDuration: const Duration(seconds: 1),
              insetAnimationCurve: Curves.fastOutSlowIn,
              elevation: 2,

              child: Container(
                height: MediaQuery.of(context).size.height*0.9,
                width: Responsive.isMobile(context)?MediaQuery.of(context).size.width*0.9:MediaQuery.of(context).size.width*0.7,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          )
                      ),
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.center,
                            child: Container(
                              padding: EdgeInsets.all(10),
                              child: Text("VIEW GROUP",textAlign: TextAlign.center,style: Theme.of(context).textTheme.headline5!.apply(color: Colors.white),),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              padding: EdgeInsets.only(top: 5,right: 10,bottom: 5),
                              child: InkWell(
                                child: CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Colors.white,
                                  child: Icon(Icons.close,color: primaryColor,size: 20,),
                                ),
                                onTap: ()=>Navigator.pop(context),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: DefaultTabController(
                          length: 4,
                          child:Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: secondaryColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: TabBar(
                                    unselectedLabelColor: Colors.grey,
                                  labelColor: primaryColor,
                                  indicatorColor: primaryColor,
                                  padding: EdgeInsets.all(5),

                                  indicator:  UnderlineTabIndicator(
                            borderSide: BorderSide(width: 1,color: primaryColor),
                            insets: EdgeInsets.symmetric(horizontal:16.0)
                        ),

                                  tabs: [
                                    Tab(text: 'Sub Group 1'),
                                    Tab(text: 'Sub Group 2'),
                                    Tab(text: 'Sub Group 3'),
                                    Tab(text: 'Sub Group 4'),
                                  ],
                                ),

                              ),

                              Container(
                                //height of TabBarView
                                height: MediaQuery.of(context).size.height*0.78,

                                child: TabBarView(children: <Widget>[

                                  StreamBuilder<QuerySnapshot>(
                                    stream: FirebaseFirestore.instance.collection('sub_group1')
                                        .where("mainGroupCode",isEqualTo:model.code).snapshots(),
                                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                      if (snapshot.hasError) {
                                        return Text('Something went wrong');
                                      }

                                      if (snapshot.connectionState == ConnectionState.waiting) {
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }

                                      if (snapshot.data!.size==0) {
                                        return Center(
                                          child: Text("No Groups"),
                                        );
                                      }

                                      return ListView(
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        children: snapshot.data!.docs.map((DocumentSnapshot document) {
                                          Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                                          MainGroupModel model=MainGroupModel.fromMap(data,document.reference.id);
                                          return ListTile(
                                            leading: Icon(Icons.people),
                                            title: Text(model.name),
                                            subtitle: Text(model.code),
                                          );
                                        }).toList(),
                                      );
                                    },
                                  ),
                                  StreamBuilder<QuerySnapshot>(
                                    stream: FirebaseFirestore.instance.collection('sub_group2')
                                        .where("mainGroupCode",isEqualTo:model.code).snapshots(),
                                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                      if (snapshot.hasError) {
                                        return Text('Something went wrong');
                                      }

                                      if (snapshot.connectionState == ConnectionState.waiting) {
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }

                                      if (snapshot.data!.size==0) {
                                        return Center(
                                          child: Text("No Groups"),
                                        );
                                      }

                                      return ListView(
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        children: snapshot.data!.docs.map((DocumentSnapshot document) {
                                          Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                                          MainGroupModel model=MainGroupModel.fromMap(data,document.reference.id);
                                          return ListTile(
                                            leading: Icon(Icons.people),
                                            title: Text(model.name),
                                            subtitle: Text(model.code),
                                          );
                                        }).toList(),
                                      );
                                    },
                                  ),
                                  StreamBuilder<QuerySnapshot>(
                                    stream: FirebaseFirestore.instance.collection('sub_group3')
                                        .where("mainGroupCode",isEqualTo:model.code).snapshots(),
                                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                      if (snapshot.hasError) {
                                        return Text('Something went wrong');
                                      }

                                      if (snapshot.connectionState == ConnectionState.waiting) {
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }

                                      if (snapshot.data!.size==0) {
                                        return Center(
                                          child: Text("No Groups"),
                                        );
                                      }

                                      return ListView(
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        children: snapshot.data!.docs.map((DocumentSnapshot document) {
                                          Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                                          MainGroupModel model=MainGroupModel.fromMap(data,document.reference.id);
                                          return ListTile(
                                            leading: Icon(Icons.people),
                                            title: Text(model.name),
                                            subtitle: Text(model.code),
                                          );
                                        }).toList(),
                                      );
                                    },
                                  ),
                                  StreamBuilder<QuerySnapshot>(
                                    stream: FirebaseFirestore.instance.collection('sub_group4')
                                        .where("mainGroupCode",isEqualTo:model.code).snapshots(),
                                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                      if (snapshot.hasError) {
                                        return Text('Something went wrong');
                                      }

                                      if (snapshot.connectionState == ConnectionState.waiting) {
                                        return Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      }

                                      if (snapshot.data!.size==0) {
                                        return Center(
                                          child: Text("No Groups"),
                                        );
                                      }

                                      return ListView(
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        children: snapshot.data!.docs.map((DocumentSnapshot document) {
                                          Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                                          MainGroupModel model=MainGroupModel.fromMap(data,document.reference.id);
                                          return ListTile(
                                            leading: Icon(Icons.people),
                                            title: Text(model.name),
                                            subtitle: Text(model.code),
                                          );
                                        }).toList(),
                                      );
                                    },
                                  ),




                                ]),
                              )

                            ],

                          )
                      ),
                    )



                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

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
            stream: FirebaseFirestore.instance.collection('main_group').orderBy('createdAt',descending: true).snapshots(),
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
                  child: Text("No group found"),
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
                    label: Text("Code"),
                  ),
                  DataColumn(
                    label: Text("Sub Groups"),
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
    final model = MainGroupModel.fromSnapshot(data);
    return DataRow(
        cells: [
          DataCell(Text(model.name)),
          DataCell(Text(model.code)),
          DataCell(
              InkWell(
                onTap: (){
                  _showSubGroupsDialog(model);
                },
                child: Text("View",),
              )
          ),
          DataCell(
            Row(
              children: [
                IconButton(
                  onPressed: (){
                    _showEditDialog(model);
                  },
                  icon: Icon(Icons.edit,color: primaryColor,),
                ),
                IconButton(
                  onPressed: ()async{
                    await FirebaseFirestore.instance.collection('main_group').doc(model.id).delete().then((value) {
                      print("deleted");
                    }).onError((error, stackTrace){

                      CoolAlert.show(
                        context: context,
                        type: CoolAlertType.error,
                        text: error.toString(),
                      );
                    });
                  },
                  icon: Icon(Icons.delete_forever,color: primaryColor,),
                ),
              ],
            ),
          ),

        ]);
  }




}




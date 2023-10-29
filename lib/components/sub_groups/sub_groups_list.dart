import 'dart:html';
import 'dart:ui' as UI;
import 'package:chat_app_admin/data/firebase_api.dart';
import 'package:chat_app_admin/model/sub_group_1_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
import '../../model/main_group_model.dart';
import '../../utils/constants.dart';
import '../../utils/responsive.dart';
class SubGroupList extends StatefulWidget {
  const SubGroupList({Key? key}) : super(key: key);

  @override
  _SubGroupListState createState() => _SubGroupListState();
}


class _SubGroupListState extends State<SubGroupList> {
  var _controller=TextEditingController();

  String filter='Main Group Code';
  String query='';

  Future<void> _showEditDialog(SubGroup1Model editModel) async {


    var _nameController=TextEditingController();
    var _codeController=TextEditingController();
    var _mainGroupCodeController=TextEditingController();

    _nameController.text=editModel.name;
    _codeController.text=editModel.code;
    _mainGroupCodeController.text=editModel.mainGroupCode;

    final _formKey = GlobalKey<FormState>();
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
                height: MediaQuery.of(context).size.height*0.4,
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
                                child: Text("EDIT SUB GROUP 1",textAlign: TextAlign.center,style: Theme.of(context).textTheme.headline5!.apply(color: Colors.white),),
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
                                  "Main Group Code",
                                  style: Theme.of(context).textTheme.bodyText1!.apply(color: Colors.black),
                                ),
                                TextFormField(
                                  controller: _mainGroupCodeController,
                                  style: TextStyle(color: Colors.black),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                  readOnly: true,
                                  onTap: (){
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context){
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
                                                  padding: EdgeInsets.all(10),
                                                  width: MediaQuery.of(context).size.width*0.3,
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        height: 50,
                                                        margin: EdgeInsets.all(10),
                                                        child: TypeAheadField(
                                                          textFieldConfiguration: TextFieldConfiguration(


                                                            decoration: InputDecoration(
                                                              contentPadding: EdgeInsets.all(15),
                                                              focusedBorder: OutlineInputBorder(
                                                                borderRadius: BorderRadius.circular(7.0),
                                                                borderSide: BorderSide(
                                                                  color: Colors.transparent,
                                                                ),
                                                              ),
                                                              enabledBorder: OutlineInputBorder(
                                                                borderRadius: BorderRadius.circular(7.0),
                                                                borderSide: BorderSide(
                                                                    color: Colors.transparent,
                                                                    width: 0.5
                                                                ),
                                                              ),
                                                              border: OutlineInputBorder(
                                                                borderRadius: BorderRadius.circular(7.0),
                                                                borderSide: BorderSide(
                                                                  color: Colors.transparent,
                                                                  width: 0.5,
                                                                ),
                                                              ),
                                                              filled: true,
                                                              fillColor: Colors.grey[200],
                                                              hintText: 'Search',
                                                              // If  you are using latest version of flutter then lable text and hint text shown like this
                                                              // if you r using flutter less then 1.20.* then maybe this is not working properly
                                                              floatingLabelBehavior: FloatingLabelBehavior.always,
                                                            ),
                                                          ),
                                                          noItemsFoundBuilder: (context) {
                                                            return ListTile(
                                                              leading: Icon(Icons.error),
                                                              title: Text("No Group Found"),
                                                            );
                                                          },
                                                          suggestionsCallback: (pattern) async {

                                                            List<MainGroupModel> search=[];
                                                            await FirebaseFirestore.instance
                                                                .collection('main_group')
                                                                .get()
                                                                .then((QuerySnapshot querySnapshot) {
                                                              querySnapshot.docs.forEach((doc) {
                                                                Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
                                                                MainGroupModel model=MainGroupModel.fromMap(data, doc.reference.id);
                                                                if ("${model.code}".contains(pattern))
                                                                  search.add(model);
                                                              });
                                                            });

                                                            return search;
                                                          },
                                                          itemBuilder: (context, MainGroupModel suggestion) {
                                                            return ListTile(
                                                              leading: Icon(Icons.people),
                                                              title: Text("${suggestion.name}"),
                                                              subtitle: Text(suggestion.code),
                                                            );
                                                          },
                                                          onSuggestionSelected: (MainGroupModel suggestion) {
                                                            _mainGroupCodeController.text=suggestion.code;
                                                            Navigator.pop(context);

                                                          },
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: StreamBuilder<QuerySnapshot>(
                                                          stream: FirebaseFirestore.instance.collection('main_group').snapshots(),
                                                          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                                            if (snapshot.hasError) {
                                                              return Center(
                                                                child: Column(
                                                                  children: [
                                                                    Image.asset("assets/images/wrong.png",width: 150,height: 150,),
                                                                    Text("Something Went Wrong",style: TextStyle(color: Colors.black))

                                                                  ],
                                                                ),
                                                              );
                                                            }

                                                            if (snapshot.connectionState == ConnectionState.waiting) {
                                                              return Center(
                                                                child: CircularProgressIndicator(),
                                                              );
                                                            }
                                                            if (snapshot.data!.size==0){
                                                              return Center(
                                                                  child: Text("No Main Group Added",style: TextStyle(color: Colors.black))
                                                              );

                                                            }

                                                            return new ListView(
                                                              shrinkWrap: true,
                                                              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                                                                Map<String, dynamic> data = document.data() as Map<String, dynamic>;

                                                                return new Padding(
                                                                  padding: const EdgeInsets.only(top: 15.0),
                                                                  child: ListTile(
                                                                    onTap: (){
                                                                      setState(() {
                                                                        _mainGroupCodeController.text="${data['code']}";
                                                                      });
                                                                      Navigator.pop(context);
                                                                    },
                                                                    leading: Icon(Icons.people),
                                                                    title: Text("${data['name']}",style: TextStyle(color: Colors.black),),
                                                                    subtitle: Text("${data['code']}",style: TextStyle(color: Colors.black),),
                                                                  ),
                                                                );
                                                              }).toList(),
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        }
                                    );
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
                                  "Sub Group Name",
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
                                  "Sub Group Code",
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
                                await FirebaseFirestore.instance.collection('sub_group1').doc(editModel.id).update({
                                  "code":"${_mainGroupCodeController.text}-${_codeController.text}",
                                  "name":_nameController.text,
                                  "mainGroupCode":_mainGroupCodeController.text,
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
                                child: Text("Add Sub Group 1",style: Theme.of(context).textTheme.button!.apply(color: Colors.white),),
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
  Future<void> _showSubGroupsDialog(SubGroup1Model model) async {


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
                          length: 3,
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
                                    stream: FirebaseFirestore.instance.collection('sub_group2')
                                        .where("subGroup1Code",isEqualTo:model.code).snapshots(),
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
                                        .where("subGroup1Code",isEqualTo:model.code).snapshots(),
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
                                        .where("subGroup1Code",isEqualTo:model.code).snapshots(),
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
        height: MediaQuery.of(context).size.height*0.8,
        width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),

      child: Column(
        children: [
          /*SizedBox(
              height: MediaQuery.of(context).size.height*0.8,
              width: MediaQuery.of(context).size.width,
              child:StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('sub_group1').orderBy('createdAt',descending: true).snapshots(),
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
                        label: Text("Main Group Code"),
                      ),
                      DataColumn(
                        label: Text("Sub Group Name"),
                      ),

                      DataColumn(
                        label: Text("Sub Group Code"),
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

          ),*/
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
                      items: ['Main Group Code','Sub Group 1'].map<DropdownMenuItem<String>>((String value) {
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
            child: FutureBuilder<List<SubGroup1Model>>(
                future: FirebaseApi.getAllSubgroup1Filtered(filter,query),
                builder: (context, AsyncSnapshot<List<SubGroup1Model>> snapshot) {
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
                          columns: [
                            DataColumn(
                              label: Text("Main Group Code"),
                            ),
                            DataColumn(
                              label: Text("Sub Group Name"),
                            ),

                            DataColumn(
                              label: Text("Sub Group Code"),
                            ),
                            DataColumn(
                              label: Text("Sub Groups"),
                            ),
                            DataColumn(
                              label: Text("Actions"),
                            ),

                          ],
                          rows: List<DataRow>.generate(snapshot.data!.length, (index){
                            return DataRow(
                                cells: [
                                  DataCell(Text(snapshot.data![index].mainGroupCode)),
                                  DataCell(Text(snapshot.data![index].name)),
                                  DataCell(Text(snapshot.data![index].code)),
                                  DataCell(
                                      InkWell(
                                        onTap: (){
                                          _showSubGroupsDialog(snapshot.data![index]);
                                        },
                                        child: Text("View",),
                                      )
                                  ),
                                  DataCell(
                                    Row(
                                      children: [
                                        IconButton(
                                          onPressed: (){
                                            _showEditDialog(snapshot.data![index]);
                                          },
                                          icon: Icon(Icons.edit,color: primaryColor,),
                                        ),
                                        IconButton(
                                          onPressed: ()async{
                                            await FirebaseFirestore.instance.collection('sub_group1').doc(snapshot.data![index].id).delete().then((value) {
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
                          })
                      );
                    }
                  }
                }
            ),
          ),
        ],
      )
    );
  }




}




import 'dart:html';
import 'dart:ui' as UI;
import 'package:chat_app_admin/components/groups/groups_list.dart';
import 'package:chat_app_admin/components/sub_groups/sub_groups2_list.dart';
import 'package:chat_app_admin/components/sub_groups/sub_groups3_list.dart';
import 'package:chat_app_admin/components/sub_groups/sub_groups4_list.dart';
import 'package:chat_app_admin/components/sub_groups/sub_groups_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
import '../../model/main_group_model.dart';
import '../../utils/constants.dart';
import '../../utils/header.dart';
import '../../utils/responsive.dart';
class SubGroups extends StatefulWidget {

  GlobalKey<ScaffoldState> _scaffoldKey;

  int index;
  SubGroups(this._scaffoldKey,this.index);

  @override
  _SubGroupsState createState() => _SubGroupsState();
}

class _SubGroupsState extends State<SubGroups> {



  Future<void> _showAdd1Dialog() async {
    var _nameController=TextEditingController();
    var _codeController=TextEditingController();
    var _mainGroupCodeController=TextEditingController();

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
                                child: Text("ADD SUB GROUP 1",textAlign: TextAlign.center,style: Theme.of(context).textTheme.headline5!.apply(color: Colors.white),),
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
                                await FirebaseFirestore.instance.collection('sub_group1').add({
                                  "code":"${_codeController.text}",
                                  "name":_nameController.text,
                                  "mainGroupCode":_mainGroupCodeController.text,
                                  "status":"Active",
                                  "createdAt":DateTime.now().millisecondsSinceEpoch,
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
  Future<void> _showAdd2Dialog() async {
    var _nameController=TextEditingController();
    var _codeController=TextEditingController();
    var _mainGroupCodeController=TextEditingController();
    var _subGroup1CodeController=TextEditingController();

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
                height: MediaQuery.of(context).size.height*0.6,
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
                                child: Text("ADD SUB GROUP ${widget.index}",textAlign: TextAlign.center,style: Theme.of(context).textTheme.headline5!.apply(color: Colors.white),),
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
                                  style: TextStyle(color: Colors.black),
                                  validator: (value) {

                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                  controller: _mainGroupCodeController,
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
                                  "Sub Group 1 Code",
                                  style: Theme.of(context).textTheme.bodyText1!.apply(color: Colors.black),
                                ),
                                TextFormField(
                                  style: TextStyle(color: Colors.black),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                  controller: _subGroup1CodeController,
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
                                                                .collection('sub_group1').where("mainGroupCode",isEqualTo: _mainGroupCodeController.text)
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
                                                            _subGroup1CodeController.text=suggestion.code;
                                                            Navigator.pop(context);

                                                          },
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: StreamBuilder<QuerySnapshot>(
                                                          stream: FirebaseFirestore.instance.collection('sub_group1').where("mainGroupCode",isEqualTo: _mainGroupCodeController.text).snapshots(),
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
                                                                  child: Text("No Sub Group Added",style: TextStyle(color: Colors.black))
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
                                                                        _subGroup1CodeController.text="${data['code']}";
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
                                  "Sub Group 2 Name",
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
                            SizedBox(height: 10,),


                            InkWell(
                              onTap: ()async{
                                final ProgressDialog pr = ProgressDialog(context: context);
                                pr.show(max: 100, msg: "Please wait");
                                int count=0;
                                await FirebaseFirestore.instance.collection('sub_group2')
                                    .where("subGroup1Code",isEqualTo:_subGroup1CodeController.text.trim())
                                    .where("mainGroupCode",isEqualTo:_mainGroupCodeController.text.trim())
                                    .orderBy("codeCount",descending: false)
                                    .get().then((QuerySnapshot querySnapshot) {
                                  querySnapshot.docs.forEach((doc) {
                                    Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
                                    print("code count ${data['codeCount']}");
                                    count=data['codeCount'];
                                  });
                                });
                                count+=1;
                                String subCode="";
                                if(count.toString().length==1){
                                  subCode="00${count}";
                                }
                                else if(count.toString().length==2){
                                  subCode="0${count}";
                                }
                                else{
                                  subCode="${count}";
                                }


                                await FirebaseFirestore.instance.collection('sub_group2').add({
                                  "code":"${_subGroup1CodeController.text}-$subCode",
                                  "name":_nameController.text,
                                  "mainGroupCode":_mainGroupCodeController.text,
                                  "subGroup1Code":_subGroup1CodeController.text,
                                  "status":"Active",
                                  "codeCount":count,
                                  "createdAt":DateTime.now().millisecondsSinceEpoch,
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
                                child: Text("Add Sub Group ${widget.index}",style: Theme.of(context).textTheme.button!.apply(color: Colors.white),),
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
  Future<void> _showAdd3Dialog() async {

    var _nameController=TextEditingController();
    var _mainGroupCodeController=TextEditingController();
    var _subGroup1CodeController=TextEditingController();
    var _subGroup2CodeController=TextEditingController();

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
                height: MediaQuery.of(context).size.height*0.5,
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
                                child: Text("ADD SUB GROUP ${widget.index}",textAlign: TextAlign.center,style: Theme.of(context).textTheme.headline5!.apply(color: Colors.white),),
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
                                  style: TextStyle(color: Colors.black),
                                  validator: (value) {

                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                  controller: _mainGroupCodeController,
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
                                  "Sub Group 1 Code",
                                  style: Theme.of(context).textTheme.bodyText1!.apply(color: Colors.black),
                                ),
                                TextFormField(
                                  style: TextStyle(color: Colors.black),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                  controller: _subGroup1CodeController,
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
                                                                .collection('sub_group1').where("mainGroupCode",isEqualTo: _mainGroupCodeController.text)
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
                                                            _subGroup1CodeController.text=suggestion.code;
                                                            Navigator.pop(context);

                                                          },
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: StreamBuilder<QuerySnapshot>(
                                                          stream: FirebaseFirestore.instance.collection('sub_group1').where("mainGroupCode",isEqualTo: _mainGroupCodeController.text).snapshots(),
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
                                                                  child: Text("No Sub Group Added",style: TextStyle(color: Colors.black))
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
                                                                        _subGroup1CodeController.text="${data['code']}";
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
                                  "Sub Group 2 Code",
                                  style: Theme.of(context).textTheme.bodyText1!.apply(color: Colors.black),
                                ),
                                TextFormField(
                                  style: TextStyle(color: Colors.black),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                  controller: _subGroup2CodeController,
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
                                                                .collection('sub_group2').where("subGroup1Code",isEqualTo: _subGroup1CodeController.text)
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
                                                            _subGroup2CodeController.text=suggestion.code;
                                                            Navigator.pop(context);

                                                          },
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: StreamBuilder<QuerySnapshot>(
                                                          stream: FirebaseFirestore.instance.collection('sub_group2').where("subGroup1Code",isEqualTo: _subGroup1CodeController.text).snapshots(),
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
                                                                  child: Text("No Sub Group Added",style: TextStyle(color: Colors.black))
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
                                                                        _subGroup2CodeController.text="${data['code']}";
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
                                  "Sub Group 3 Name",
                                  style: Theme.of(context).textTheme.bodyText1!.apply(color: Colors.black),
                                ),
                                TextFormField(
                                  style: TextStyle(color: Colors.black),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                  controller: _nameController,
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
                                int count=0;
                                await FirebaseFirestore.instance.collection('sub_group3')
                                    .where("subGroup2Code",isEqualTo:_subGroup2CodeController.text.trim())
                                    .where("subGroup1Code",isEqualTo:_subGroup1CodeController.text.trim())
                                    .where("mainGroupCode",isEqualTo:_mainGroupCodeController.text.trim())
                                    .orderBy("codeCount",descending: false)
                                    .get().then((QuerySnapshot querySnapshot) {
                                  querySnapshot.docs.forEach((doc) {
                                    Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
                                    print("code count ${data['codeCount']}");
                                    count=data['codeCount'];
                                  });
                                });
                                count+=1;
                                String subCode="";
                                if(count.toString().length==1){
                                  subCode="00${count}";
                                }
                                else if(count.toString().length==2){
                                  subCode="0${count}";
                                }
                                else{
                                  subCode="${count}";
                                }
                                await FirebaseFirestore.instance.collection('sub_group3').add({
                                  "code":'${_subGroup2CodeController.text}-$subCode',
                                  "name":_nameController.text,
                                  "mainGroupCode":_mainGroupCodeController.text,
                                  "subGroup1Code":_subGroup1CodeController.text,
                                  "subGroup2Code":_subGroup2CodeController.text,
                                  "status":"Active",
                                  "codeCount":count,
                                  "createdAt":DateTime.now().millisecondsSinceEpoch,
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
                                child: Text("Add Sub Group ${widget.index}",style: Theme.of(context).textTheme.button!.apply(color: Colors.white),),
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
  Future<void> _showAdd4Dialog() async {

    var _nameController=TextEditingController();
    var _mainGroupCodeController=TextEditingController();
    var _subGroup1CodeController=TextEditingController();
    var _subGroup2CodeController=TextEditingController();
    var _subGroup3CodeController=TextEditingController();

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
                height: MediaQuery.of(context).size.height*0.7,
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
                                child: Text("ADD SUB GROUP ${widget.index}",textAlign: TextAlign.center,style: Theme.of(context).textTheme.headline5!.apply(color: Colors.white),),
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
                                  style: TextStyle(color: Colors.black),
                                  validator: (value) {

                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                  controller: _mainGroupCodeController,
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
                                  "Sub Group 1 Code",
                                  style: Theme.of(context).textTheme.bodyText1!.apply(color: Colors.black),
                                ),
                                TextFormField(
                                  style: TextStyle(color: Colors.black),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                  controller: _subGroup1CodeController,
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
                                                                .collection('sub_group1').where("mainGroupCode",isEqualTo: _mainGroupCodeController.text)
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
                                                            _subGroup1CodeController.text=suggestion.code;
                                                            Navigator.pop(context);

                                                          },
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: StreamBuilder<QuerySnapshot>(
                                                          stream: FirebaseFirestore.instance.collection('sub_group1').where("mainGroupCode",isEqualTo: _mainGroupCodeController.text).snapshots(),
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
                                                                  child: Text("No Sub Group Added",style: TextStyle(color: Colors.black))
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
                                                                        _subGroup1CodeController.text="${data['code']}";
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
                                  "Sub Group 2 Code",
                                  style: Theme.of(context).textTheme.bodyText1!.apply(color: Colors.black),
                                ),
                                TextFormField(
                                  style: TextStyle(color: Colors.black),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                  controller: _subGroup2CodeController,
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
                                                                .collection('sub_group2').where("subGroup1Code",isEqualTo: _subGroup1CodeController.text)
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
                                                            _subGroup2CodeController.text=suggestion.code;
                                                            Navigator.pop(context);

                                                          },
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: StreamBuilder<QuerySnapshot>(
                                                          stream: FirebaseFirestore.instance.collection('sub_group2').where("subGroup1Code",isEqualTo: _subGroup1CodeController.text).snapshots(),
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
                                                                  child: Text("No Sub Group Added",style: TextStyle(color: Colors.black))
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
                                                                        _subGroup2CodeController.text="${data['code']}";
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
                                  "Sub Group 3 Code",
                                  style: Theme.of(context).textTheme.bodyText1!.apply(color: Colors.black),
                                ),
                                TextFormField(
                                  style: TextStyle(color: Colors.black),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                  controller: _subGroup3CodeController,
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
                                                                .collection('sub_group3').where("subGroup2Code",isEqualTo: _subGroup2CodeController.text)
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
                                                            _subGroup3CodeController.text=suggestion.code;
                                                            Navigator.pop(context);

                                                          },
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: StreamBuilder<QuerySnapshot>(
                                                          stream: FirebaseFirestore.instance.collection('sub_group3').where("subGroup2Code",isEqualTo: _subGroup2CodeController.text).snapshots(),
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
                                                                  child: Text("No Sub Group Added",style: TextStyle(color: Colors.black))
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
                                                                        _subGroup3CodeController.text="${data['code']}";
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
                                  "Sub Group 4 Name",
                                  style: Theme.of(context).textTheme.bodyText1!.apply(color: Colors.black),
                                ),
                                TextFormField(
                                  style: TextStyle(color: Colors.black),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                  controller: _nameController,
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
                                int count=0;
                                await FirebaseFirestore.instance.collection('sub_group4')
                                    .where("subGroup3Code",isEqualTo:_subGroup3CodeController.text.trim())
                                    .where("subGroup2Code",isEqualTo:_subGroup2CodeController.text.trim())
                                    .where("subGroup1Code",isEqualTo:_subGroup1CodeController.text.trim())
                                    .where("mainGroupCode",isEqualTo:_mainGroupCodeController.text.trim())
                                    .orderBy("codeCount",descending: false)
                                    .get().then((QuerySnapshot querySnapshot) {
                                  querySnapshot.docs.forEach((doc) {
                                    Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
                                    print("code count ${data['codeCount']}");
                                    count=data['codeCount'];
                                  });
                                });
                                print("pre code $count");
                                count+=1;
                                print("post code $count");
                                String subCode="";
                                if(count.toString().length==1){
                                  subCode="00${count}";
                                }
                                else if(count.toString().length==2){
                                  subCode="0${count}";
                                }
                                else{
                                  subCode="${count}";
                                }
                                await FirebaseFirestore.instance.collection('sub_group4').add({
                                  "code":'${_subGroup3CodeController.text}-$subCode',
                                  "name":_nameController.text,
                                  "mainGroupCode":_mainGroupCodeController.text,
                                  "subGroup1Code":_subGroup1CodeController.text,
                                  "subGroup2Code":_subGroup2CodeController.text,
                                  "subGroup3Code":_subGroup3CodeController.text,
                                  "status":"Active",
                                  "codeCount":count,

                                  "createdAt":DateTime.now().millisecondsSinceEpoch,
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
                                child: Text("Add Sub Group ${widget.index}",style: Theme.of(context).textTheme.button!.apply(color: Colors.white),),
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
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Header("Sub Group ${widget.index}",widget._scaffoldKey),
            SizedBox(height: defaultPadding),
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
                          ElevatedButton.icon(
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                horizontal: defaultPadding * 1.5,
                                vertical:
                                defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                              ),
                            ),
                            onPressed: ()async {
                              if(widget.index==1){
                                _showAdd1Dialog();
                              }
                              else if(widget.index==2){
                                _showAdd2Dialog();
                              }
                              else if(widget.index==3){
                                _showAdd3Dialog();
                              }
                              else if(widget.index==4){
                                _showAdd4Dialog();
                              }
                            },
                            icon: Icon(Icons.add),
                            label: Text("Add Sub Group ${widget.index}"),
                          ),
                        ],
                      ),

                      SizedBox(height: defaultPadding),
                      if(widget.index==1)
                        SubGroupList()
                      else if(widget.index==2)
                        SubGroup2List()
                      else if(widget.index==3)
                          SubGroup3List()
                        else if(widget.index==4)
                            SubGroup4List(),
                      if (Responsive.isMobile(context))
                        SizedBox(height: defaultPadding),
                    ],
                  ),
                ),
                if (!Responsive.isMobile(context))
                  SizedBox(width: defaultPadding),


              ],
            )
          ],
        ),
      ),
    );
  }

  /*Future<void> _showAddDialog() async {
    int _step = 0;
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
                width: MediaQuery.of(context).size.width*0.5,
                height: MediaQuery.of(context).size.width*0.9,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Stack(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            margin: EdgeInsets.all(10),
                            child: Text("Add Teacher",textAlign: TextAlign.center,style: Theme.of(context).textTheme.headline5!.apply(color: Colors.black),),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            margin: EdgeInsets.all(10),
                            child: IconButton(
                              icon: Icon(Icons.close,color: Colors.grey,),
                              onPressed: ()=>Navigator.pop(context),
                            ),
                          ),
                        )
                      ],
                    ),
                    Expanded(
                      child: Stepper(
                        type: StepperType.horizontal,
                        controlsBuilder: (BuildContext context, ControlsDetails controls) {
                          return Row(
                            children: <Widget>[
                              TextButton(
                                onPressed: controls.onStepContinue,
                                child: _step==3?  Text('Add Teacher'):Text('Continue'),
                              ),
                              TextButton(
                                onPressed: controls.onStepCancel,
                                child: const Text('Back'),
                              ),
                            ],
                          );
                        },
                        currentStep: _step,
                        onStepCancel: () {
                          if (_step > 0) {
                            setState(() { _step -= 1; });
                          }
                        },
                        onStepContinue: () {
                          if (_step < 3) {
                            setState(() { _step += 1; });
                            print("step continue $_step");
                          }

                        },
                        onStepTapped: (int index) {
                          setState(() { _step = index; });
                        },
                        steps: <Step>[
                          Step(
                            isActive: _step >= 0?true:false,
                            state: _step >= 1 ? StepState.complete : StepState.disabled,
                            title: Text('Group'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
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
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Code",
                                      style: Theme.of(context).textTheme.bodyText1!.apply(color: Colors.black),
                                    ),
                                    TextFormField(
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


                              ],
                            ),
                          ),
                          Step(
                              isActive: _step >= 1?true:false,
                              state: _step >= 2 ? StepState.complete : StepState.disabled,
                              title: Text('Sub Group 1'),
                              content: Column(
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
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Code",
                                        style: Theme.of(context).textTheme.bodyText1!.apply(color: Colors.black),
                                      ),
                                      TextFormField(
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

                                    },
                                    child: Container(
                                      height: 50,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(7),
                                        color: primaryColor,
                                      ),
                                      alignment: Alignment.center,
                                      child: Text("Add Sub Group",style: Theme.of(context).textTheme.button!.apply(color: Colors.white),),
                                    ),
                                  ),
                                  SizedBox(height: 10,),

                                  Container(
                                    height: MediaQuery.of(context).size.height*0.4,
                                    color: Colors.green,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: 10,
                                      itemBuilder: (context,int i){
                                        return Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: CheckboxListTile(
                                              title: Text("tempDepartments[i].model.name"),
                                              value: true,
                                              onChanged: (bool? value) {

                                              },
                                            )
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              )
                          ),
                          Step(
                            isActive: _step >= 2?true:false,
                            state: _step >= 3 ? StepState.complete : StepState.disabled,
                            title: Text('Sub Group 2'),
                            content: Container(
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: 10,
                                itemBuilder: (context,int i){
                                  return Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: CheckboxListTile(
                                        title: Text("tempDepartments[i].model.name"),
                                        value: true,
                                        onChanged: (bool? value) {

                                        },
                                      )
                                  );
                                },
                              ),
                            ),
                          ),
                          Step(
                            isActive:_step >= 3?true:false,
                            state: _step >= 4 ? StepState.complete : StepState.disabled,
                            title: Text('Sub Group 3'),
                            content:Container(
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: 10,
                                itemBuilder: (context,int i){
                                  return Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: CheckboxListTile(
                                        title: Text("tempDepartments[i].model.name"),
                                        value: true,
                                        onChanged: (bool? value) {

                                        },
                                      )
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }*/
}

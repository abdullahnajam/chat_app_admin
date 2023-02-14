import 'dart:html';
import 'dart:ui' as UI;
import 'package:chat_app_admin/model/invited_user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
import '../../model/attributes_model.dart';
import '../../model/main_group_model.dart';
import '../../model/occupation_model.dart';
import '../../utils/constants.dart';
import '../../utils/responsive.dart';
class InvitedUserList extends StatefulWidget {
  const InvitedUserList({Key? key}) : super(key: key);

  @override
  _InvitedUserListState createState() => _InvitedUserListState();
}


class _InvitedUserListState extends State<InvitedUserList> {


  Future<void> _showEditDialog(InvitedUserModel model) async {
    var _nameController=TextEditingController();
    var _emailController=TextEditingController();
    var _mobileController=TextEditingController();

    var _mainGroupCodeController=TextEditingController();
    var _subGroup1CodeController=TextEditingController();
    var _subGroup2CodeController=TextEditingController();
    var _subGroup3CodeController=TextEditingController();
    var _subGroup4CodeController=TextEditingController();
    //var _resTypeController=TextEditingController();
    var _addResController=TextEditingController();

    String mainGroupCode=model.mainGroup;
    String subGroup1Code=model.subGroup1Code;
    String subGroup2Code=model.subGroup2Code;
    String subGroup3Code=model.subGroup3Code;
    String subGroup4Code=model.subGroup4Code;
    //_resTypeController.text=model.res_type;
    _addResController.text=model.additionalResponsibility;

    bool referer=model.referer;

    _nameController.text=model.name;
    _emailController.text=model.email;
    _mobileController.text=model.mobile;
    String dropdownValue=model.gender;
    _mainGroupCodeController.text=model.mainGroup;
    _subGroup1CodeController.text=model.subGroup1;
    _subGroup2CodeController.text=model.subGroup2;
    _subGroup3CodeController.text=model.subGroup3;
    _subGroup4CodeController.text=model.subGroup4;

    String additionalResponsibilityCode=model.additionalResponsibilityCode;

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
                height: MediaQuery.of(context).size.height*0.9,
                width: Responsive.isMobile(context)?MediaQuery.of(context).size.width*0.9:MediaQuery.of(context).size.width*0.7,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)
                ),
                child:  Column(
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
                              child: Text("EDIT USER",textAlign: TextAlign.center,style: Theme.of(context).textTheme.headline5!.apply(color: Colors.white),),
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
                      child: Form(
                        key: _formKey,
                        child: ListView(
                          padding: EdgeInsets.all(10),
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Group Details",style: Theme.of(context).textTheme.headline6!.apply(color: Colors.black),),
                                SizedBox(height: 30,),

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
                                                                _mainGroupCodeController.text="${suggestion.code} - ${suggestion.name}";
                                                                mainGroupCode=suggestion.code;
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
                                                                            mainGroupCode=data['code'];
                                                                            _mainGroupCodeController.text="${data['code']} - ${data['name']}";
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
                                                                    .collection('sub_group1').where("mainGroupCode",isEqualTo: mainGroupCode)
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
                                                                _subGroup1CodeController.text="${suggestion.code} - ${suggestion.name}";
                                                                subGroup1Code=suggestion.code;
                                                                Navigator.pop(context);

                                                              },
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: StreamBuilder<QuerySnapshot>(
                                                              stream: FirebaseFirestore.instance.collection('sub_group1').where("mainGroupCode",isEqualTo: mainGroupCode).snapshots(),
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
                                                                            subGroup1Code=data['code'];
                                                                            _subGroup1CodeController.text="${data['code']} - ${data['name']}";
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
                                                                    .collection('sub_group2').where("subGroup1Code",isEqualTo: subGroup1Code)
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
                                                                _subGroup2CodeController.text="${suggestion.code} - ${suggestion.name}";
                                                                subGroup2Code=suggestion.code;
                                                                Navigator.pop(context);

                                                              },
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: StreamBuilder<QuerySnapshot>(
                                                              stream: FirebaseFirestore.instance.collection('sub_group2').where("subGroup1Code",isEqualTo: subGroup1Code).snapshots(),
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
                                                                            subGroup2Code=data['code'];
                                                                            _subGroup2CodeController.text="${data['code']} - ${data['name']}";
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
                                                                    .collection('sub_group3').where("subGroup2Code",isEqualTo: subGroup2Code)
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
                                                                _subGroup3CodeController.text="${suggestion.code} - ${suggestion.name}";
                                                                subGroup3Code=suggestion.code;
                                                                Navigator.pop(context);

                                                              },
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: StreamBuilder<QuerySnapshot>(
                                                              stream: FirebaseFirestore.instance.collection('sub_group3').where("subGroup2Code",isEqualTo: subGroup2Code).snapshots(),
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
                                                                            subGroup3Code=data['code'];
                                                                            _subGroup3CodeController.text="${data['code']} - ${data['name']}";
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
                                      "Sub Group 4 Code",
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
                                      controller: _subGroup4CodeController,
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
                                                                    .collection('sub_group4').where("subGroup3Code",isEqualTo: subGroup3Code)
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
                                                                _subGroup4CodeController.text="${suggestion.code} - ${suggestion.name}";
                                                                subGroup4Code=suggestion.code;
                                                                Navigator.pop(context);

                                                              },
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: StreamBuilder<QuerySnapshot>(
                                                              stream: FirebaseFirestore.instance.collection('sub_group4').where("subGroup3Code",isEqualTo:subGroup3Code).snapshots(),
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
                                                                            subGroup4Code=data['code'];
                                                                            _subGroup4CodeController.text="${data['code']} - ${data['name']}";
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
                                  "Email",
                                  style: Theme.of(context).textTheme.bodyText1!.apply(color: Colors.black),
                                ),
                                TextFormField(
                                  controller: _emailController,
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
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 10),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Mobile",
                                          style: Theme.of(context).textTheme.bodyText1!.apply(color: Colors.black),
                                        ),
                                        TextFormField(
                                          controller: _mobileController,
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
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 10),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Gender",
                                          style: Theme.of(context).textTheme.bodyText1!.apply(color: Colors.black),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(left: 5,right: 5),
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(7),
                                              border:Border.all(color: primaryColor)
                                          ),
                                          child: DropdownButton<String>(
                                            value: dropdownValue,
                                            icon: const Icon(Icons.arrow_downward),
                                            elevation: 16,
                                            isExpanded: true,
                                            style: const TextStyle(),
                                            underline: Container(
                                            ),
                                            onChanged: (String? value) {
                                              // This is called when the user selects an item.
                                              setState(() {
                                                dropdownValue = value!;
                                              });
                                            },
                                            items: list.map<DropdownMenuItem<String>>((String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                            }).toList(),
                                          ),
                                        ),

                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 20,),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Additional Responsibility",
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
                                  controller: _addResController,
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
                                                              title: Text("No Data Found"),
                                                            );
                                                          },
                                                          suggestionsCallback: (pattern) async {

                                                            List<OccupationModel> search=[];
                                                            await FirebaseFirestore.instance
                                                                .collection('additional_responsibility')
                                                                .get()
                                                                .then((QuerySnapshot querySnapshot) {
                                                              querySnapshot.docs.forEach((doc) {
                                                                Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
                                                                OccupationModel model=OccupationModel.fromMap(data, doc.reference.id);
                                                                if ("${model.code}".contains(pattern))
                                                                  search.add(model);
                                                              });
                                                            });

                                                            return search;
                                                          },
                                                          itemBuilder: (context, OccupationModel suggestion) {
                                                            return ListTile(
                                                              leading: Icon(Icons.people),
                                                              title: Text("${suggestion.name}"),
                                                              subtitle: Text(suggestion.code),
                                                            );
                                                          },
                                                          onSuggestionSelected: (OccupationModel suggestion) {
                                                            _addResController.text="${suggestion.name}";
                                                            additionalResponsibilityCode=suggestion.code;
                                                            Navigator.pop(context);

                                                          },
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: StreamBuilder<QuerySnapshot>(
                                                          stream: FirebaseFirestore.instance.collection('additional_responsibility').snapshots(),
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
                                                                  child: Text("No Data Added",style: TextStyle(color: Colors.black))
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
                                                                        additionalResponsibilityCode=data['code'];
                                                                        _addResController.text="${data['name']}";
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
                            /*SizedBox(height: 20,),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Additional Responsibility Type",
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
                                  controller: _resTypeController,
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
                                                              title: Text("No Data Found"),
                                                            );
                                                          },
                                                          suggestionsCallback: (pattern) async {

                                                            List<AttributeModel> search=[];
                                                            await FirebaseFirestore.instance
                                                                .collection('res_type')
                                                                .get()
                                                                .then((QuerySnapshot querySnapshot) {
                                                              querySnapshot.docs.forEach((doc) {
                                                                Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
                                                                AttributeModel model=AttributeModel.fromMap(data, doc.reference.id);
                                                                if ("${model.code}".contains(pattern))
                                                                  search.add(model);
                                                              });
                                                            });

                                                            return search;
                                                          },
                                                          itemBuilder: (context, AttributeModel suggestion) {
                                                            return ListTile(
                                                              leading: Icon(Icons.people),
                                                              title: Text("${suggestion.name}"),
                                                              subtitle: Text(suggestion.code),
                                                            );
                                                          },
                                                          onSuggestionSelected: (AttributeModel suggestion) {
                                                            _resTypeController.text="${suggestion.name}";
                                                            Navigator.pop(context);

                                                          },
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: StreamBuilder<QuerySnapshot>(
                                                          stream: FirebaseFirestore.instance.collection('res_type').snapshots(),
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
                                                                  child: Text("No Data Added",style: TextStyle(color: Colors.black))
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
                                                                        _resTypeController.text="${data['name']}";
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
                            ),*/
                            SizedBox(height: 30,),

                            Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "",
                                    style: Theme.of(context).textTheme.bodyText1!.apply(color: Colors.black),
                                  ),
                                  CheckboxListTile(
                                    value: referer,
                                    onChanged: (value){
                                      setState(() {
                                        referer = value!;
                                      });
                                    },
                                    title: Text("Refferer"),
                                    controlAffinity: ListTileControlAffinity.leading,
                                  ),


                                ]
                            ),
                            SizedBox(height: 10,),
                            InkWell(
                              onTap: ()async{
                                if (_formKey.currentState!.validate()){
                                  final ProgressDialog pr = ProgressDialog(context: context);
                                  pr.show(max: 100, msg: "Please wait");
                                  await FirebaseFirestore.instance.collection('invited_users').doc(model.id).update({
                                    "name":_nameController.text,
                                    "email":_emailController.text,
                                    "mobile":_mobileController.text,
                                    "gender":dropdownValue,
                                    "referer":referer,
                                    "mainGroupCode":mainGroupCode,
                                    "subGroup1Code":subGroup1Code,
                                    "subGroup2Code":subGroup2Code,
                                    "subGroup3Code":subGroup3Code,
                                    //"res_type":_resTypeController.text,
                                    "additionalResponsibility":_addResController.text,
                                    "additionalResponsibilityCode":additionalResponsibilityCode,
                                    "subGroup4Code":subGroup4Code,
                                    "mainGroup":_mainGroupCodeController.text,
                                    "subGroup1":_subGroup1CodeController.text,
                                    "subGroup2":_subGroup2CodeController.text,
                                    "subGroup3":_subGroup3CodeController.text,
                                    "subGroup4":_subGroup4CodeController.text,


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
                                }

                              },
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  color: primaryColor,
                                ),
                                alignment: Alignment.center,
                                child: Text("Update User",style: Theme.of(context).textTheme.button!.apply(color: Colors.white),),
                              ),
                            )
                          ],
                        ),
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
  Future<void> _showSubGroupsDialog(InvitedUserModel model) async {


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
                height: MediaQuery.of(context).size.height*0.32,
                width: Responsive.isMobile(context)?MediaQuery.of(context).size.width*0.7:MediaQuery.of(context).size.width*0.6,
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
                              child: Text("SUB GROUPS",textAlign: TextAlign.center,style: Theme.of(context).textTheme.headline5!.apply(color: Colors.white),),
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
                        children: [
                          ListTile(
                            leading: Icon(Icons.people),
                            title: Text(model.subGroup1),
                          ),
                          ListTile(
                            leading: Icon(Icons.people),
                            title: Text(model.subGroup2),
                          ),
                          ListTile(
                            leading: Icon(Icons.people),
                            title: Text(model.subGroup3),
                          ),
                          ListTile(
                            leading: Icon(Icons.people),
                            title: Text(model.subGroup4),
                          )
                        ],
                      )
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
            stream: FirebaseFirestore.instance.collection('invited_users').orderBy('createdAt',descending: true).snapshots(),
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
                  child: Text("No user found"),
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
                      label: Text("Mobile"),
                    ),
                    DataColumn(
                      label: Text("Gender"),
                    ),
                    DataColumn(
                      label: Text("Additional\nResponsibility\nCode"),
                    ),
                    DataColumn(
                      label: Text("Additional\nResponsibility\nType"),
                    ),
                    DataColumn(
                      label: Text("Group"),
                    ),
                    DataColumn(
                      label: Text("Sub Group"),
                    ),
                    DataColumn(
                      label: Text("Refferer"),
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
    final model = InvitedUserModel.fromSnapshot(data);
    return DataRow(
        cells: [
          DataCell(Text(model.name)),
          DataCell(Text(model.email)),
          DataCell(Text(model.mobile)),
          DataCell(Text(model.gender)),
          DataCell(
            Text(model.additionalResponsibilityCode),
          ),
          DataCell(
            Text(model.additionalResponsibility),
          ),
          DataCell(Text(model.mainGroup)),
          DataCell(
              InkWell(
                onTap: (){
                  _showSubGroupsDialog(model);
                },
                child: Text("View",),
              )
          ),
          DataCell(Text(model.referer.toString())),
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
                    await FirebaseFirestore.instance.collection('invited_user').doc(model.id).delete().then((value) {
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




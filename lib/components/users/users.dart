import 'dart:convert';
import 'dart:html';
import 'dart:typed_data';
import 'dart:ui' as UI;
import 'package:chat_app_admin/components/users/users_list.dart';
import 'package:chat_app_admin/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:file_saver/file_saver.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
import '../../data/firebase_api.dart';
import '../../model/attributes_model.dart';
import '../../model/main_group_model.dart';
import '../../model/occupation_model.dart';
import '../../utils/constants.dart';
import '../../utils/header.dart';
import '../../utils/responsive.dart';
import '../../widgets/sub_group_dialogs.dart';
class Users extends StatefulWidget {

  GlobalKey<ScaffoldState> _scaffoldKey;

  Users(this._scaffoldKey);

  @override
  _UsersState createState() => _UsersState();
}

class _UsersState extends State<Users> {

  Future<void> _showAddDialog() async {


    var _nameController=TextEditingController();
    var _emailController=TextEditingController();
    var _mobileController=TextEditingController();
    String phoneCode='+92';
    var _genderController=TextEditingController();

    var _dobController=TextEditingController();
    var _landlineController=TextEditingController();
    var _fatherNameController=TextEditingController();
    var _passwordController=TextEditingController();
    var _confirmPasswordController=TextEditingController();

    var _occupationController=TextEditingController();
    var _jobdesController=TextEditingController();
    var _addResController=TextEditingController();
    var _countryController=TextEditingController();
    var _locationController=TextEditingController();
    var _displayController=TextEditingController();



    var _mainGroupCodeController=TextEditingController();
    var _subGroup1CodeController=TextEditingController();
    var _subGroup2CodeController=TextEditingController();
    var _subGroup3CodeController=TextEditingController();
    var _subGroup4CodeController=TextEditingController();
    var _companyController=TextEditingController();


    String mainGroupCode="";
    String subGroup1Code="";
    String subGroup2Code="";
    String subGroup3Code="";
    String subGroup4Code="";
    String additionalResponsibilityCode="";

    bool referer=false;
    bool expatriates=true;
    bool additionalResponsibilityRequired=true;
    bool active=false;
    bool groupCode=false;
    bool sub1Representative=false;
    bool sub2Representative=false;
    bool sub3Representative=false;
    bool sub4Representative=false;

    String dropdownValue = list.first;

    final _formKey = GlobalKey<FormState>();
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context,setState){

            return Dialog(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
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
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
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
                                padding: const EdgeInsets.all(10),
                                child: Text("ADD USER",textAlign: TextAlign.center,style: Theme.of(context).textTheme.headline5!.apply(color: Colors.white),),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                padding: const EdgeInsets.only(top: 5,right: 10,bottom: 5),
                                child: InkWell(
                                  child: const CircleAvatar(
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
                          padding: const EdgeInsets.all(10),
                          children: [
                            Text("Group Details",style: Theme.of(context).textTheme.headline6!.apply(color: Colors.black),),
                            const SizedBox(height: 30,),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Main Group Code",
                                  style: Theme.of(context).textTheme.bodyText1!.apply(color: Colors.black),
                                ),
                                TextFormField(
                                  style: const TextStyle(color: Colors.black),
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
                                                shape: const RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0),
                                                  ),
                                                ),
                                                insetAnimationDuration: const Duration(seconds: 1),
                                                insetAnimationCurve: Curves.fastOutSlowIn,
                                                elevation: 2,
                                                child: Container(
                                                  padding: const EdgeInsets.all(10),
                                                  width: MediaQuery.of(context).size.width*0.3,
                                                  height: MediaQuery.of(context).size.height*0.7,
                                                  child: ListView(
                                                    children: [
                                                      Container(
                                                        height: 50,
                                                        margin: const EdgeInsets.all(10),
                                                        child: TypeAheadField(
                                                          textFieldConfiguration: TextFieldConfiguration(


                                                            decoration: InputDecoration(
                                                              contentPadding: const EdgeInsets.all(15),
                                                              focusedBorder: OutlineInputBorder(
                                                                borderRadius: BorderRadius.circular(7.0),
                                                                borderSide: const BorderSide(
                                                                  color: Colors.transparent,
                                                                ),
                                                              ),
                                                              enabledBorder: OutlineInputBorder(
                                                                borderRadius: BorderRadius.circular(7.0),
                                                                borderSide: const BorderSide(
                                                                    color: Colors.transparent,
                                                                    width: 0.5
                                                                ),
                                                              ),
                                                              border: OutlineInputBorder(
                                                                borderRadius: BorderRadius.circular(7.0),
                                                                borderSide: const BorderSide(
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
                                                            return const ListTile(
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
                                                                if (model.code.contains(pattern))
                                                                  search.add(model);
                                                              });
                                                            });

                                                            return search;
                                                          },
                                                          itemBuilder: (context, MainGroupModel suggestion) {
                                                            return ListTile(
                                                              leading: const Icon(Icons.people),
                                                              title: Text(suggestion.name),
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
                                                      StreamBuilder<QuerySnapshot>(
                                                        stream: FirebaseFirestore.instance.collection('main_group').snapshots(),
                                                        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                                          if (snapshot.hasError) {
                                                            return Center(
                                                              child: Column(
                                                                children: [
                                                                  Image.asset("assets/images/wrong.png",width: 150,height: 150,),
                                                                  const Text("Something Went Wrong",style: TextStyle(color: Colors.black))

                                                                ],
                                                              ),
                                                            );
                                                          }

                                                          if (snapshot.connectionState == ConnectionState.waiting) {
                                                            return const Center(
                                                              child: CircularProgressIndicator(),
                                                            );
                                                          }
                                                          if (snapshot.data!.size==0){
                                                            return const Center(
                                                                child: Text("No Main Group Added",style: TextStyle(color: Colors.black))
                                                            );

                                                          }

                                                          return ListView(
                                                            shrinkWrap: true,
                                                            physics: NeverScrollableScrollPhysics(),
                                                            children: snapshot.data!.docs.map((DocumentSnapshot document) {
                                                              Map<String, dynamic> data = document.data() as Map<String, dynamic>;

                                                              return Padding(
                                                                padding: const EdgeInsets.only(top: 15.0),
                                                                child: ListTile(
                                                                  onTap: (){
                                                                    setState(() {
                                                                      mainGroupCode=data['code'];
                                                                      _mainGroupCodeController.text="${data['code']} - ${data['name']}";
                                                                    });
                                                                    Navigator.pop(context);
                                                                  },
                                                                  leading: const Icon(Icons.people),
                                                                  title: Text("${data['name']}",style: const TextStyle(color: Colors.black),),
                                                                  subtitle: Text("${data['code']}",style: const TextStyle(color: Colors.black),),
                                                                ),
                                                              );
                                                            }).toList(),
                                                          );
                                                        },
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
                                    contentPadding: const EdgeInsets.all(15),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(7.0),
                                      borderSide: const BorderSide(
                                        color: primaryColor,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(7.0),
                                      borderSide: const BorderSide(
                                          color: primaryColor,
                                          width: 0.5
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(7.0),
                                      borderSide: const BorderSide(
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
                            const SizedBox(height: 20,),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Sub Group 1 Code",
                                  style: Theme.of(context).textTheme.bodyText1!.apply(color: Colors.black),
                                ),
                                TextFormField(
                                  style: const TextStyle(color: Colors.black),
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
                                                shape: const RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0),
                                                  ),
                                                ),
                                                insetAnimationDuration: const Duration(seconds: 1),
                                                insetAnimationCurve: Curves.fastOutSlowIn,
                                                elevation: 2,
                                                child: Container(
                                                  padding: const EdgeInsets.all(10),
                                                  width: MediaQuery.of(context).size.width*0.3,
                                                  height: MediaQuery.of(context).size.height*0.7,

                                                  child: ListView(
                                                    children: [
                                                      Container(
                                                        height: 50,
                                                        margin: const EdgeInsets.all(10),
                                                        child: TypeAheadField(
                                                          textFieldConfiguration: TextFieldConfiguration(


                                                            decoration: InputDecoration(
                                                              contentPadding: const EdgeInsets.all(15),
                                                              focusedBorder: OutlineInputBorder(
                                                                borderRadius: BorderRadius.circular(7.0),
                                                                borderSide: const BorderSide(
                                                                  color: Colors.transparent,
                                                                ),
                                                              ),
                                                              enabledBorder: OutlineInputBorder(
                                                                borderRadius: BorderRadius.circular(7.0),
                                                                borderSide: const BorderSide(
                                                                    color: Colors.transparent,
                                                                    width: 0.5
                                                                ),
                                                              ),
                                                              border: OutlineInputBorder(
                                                                borderRadius: BorderRadius.circular(7.0),
                                                                borderSide: const BorderSide(
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
                                                            return const ListTile(
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
                                                                if (model.code.contains(pattern))
                                                                  search.add(model);
                                                              });
                                                            });

                                                            return search;
                                                          },
                                                          itemBuilder: (context, MainGroupModel suggestion) {
                                                            return ListTile(
                                                              leading: const Icon(Icons.people),
                                                              title: Text(suggestion.name),
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
                                                      StreamBuilder<QuerySnapshot>(
                                                        stream: FirebaseFirestore.instance.collection('sub_group1').where("mainGroupCode",isEqualTo: mainGroupCode).snapshots(),
                                                        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                                          if (snapshot.hasError) {
                                                            return Center(
                                                              child: Column(
                                                                children: [
                                                                  Image.asset("assets/images/wrong.png",width: 150,height: 150,),
                                                                  const Text("Something Went Wrong",style: TextStyle(color: Colors.black))

                                                                ],
                                                              ),
                                                            );
                                                          }

                                                          if (snapshot.connectionState == ConnectionState.waiting) {
                                                            return const Center(
                                                              child: CircularProgressIndicator(),
                                                            );
                                                          }
                                                          if (snapshot.data!.size==0){
                                                            return Center(
                                                                child: Column(
                                                                  children: [
                                                                    SizedBox(height: 20,),
                                                                    Text("No Sub Group Added",style: TextStyle(color: Colors.black)),
                                                                    SizedBox(height: 10,),
                                                                    ElevatedButton.icon(
                                                                      style: TextButton.styleFrom(
                                                                        padding: EdgeInsets.symmetric(
                                                                          horizontal: defaultPadding * 1.5,
                                                                          vertical:
                                                                          defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                                                                        ),
                                                                      ),
                                                                      onPressed: ()async {
                                                                        SubGroupDialogs.showAdd1Dialog(context);
                                                                      },
                                                                      icon: const Icon(Icons.add),
                                                                      label: Text("Add Sub Group 1"),
                                                                    ),
                                                                  ],
                                                                )
                                                            );

                                                          }

                                                          return ListView(
                                                            physics: NeverScrollableScrollPhysics(),
                                                            shrinkWrap: true,
                                                            children: snapshot.data!.docs.map((DocumentSnapshot document) {
                                                              Map<String, dynamic> data = document.data() as Map<String, dynamic>;

                                                              return Padding(
                                                                padding: const EdgeInsets.only(top: 15.0),
                                                                child: ListTile(
                                                                  onTap: (){
                                                                    setState(() {
                                                                      subGroup1Code=data['code'];
                                                                      _subGroup1CodeController.text="${data['code']} - ${data['name']}";
                                                                    });
                                                                    Navigator.pop(context);
                                                                  },
                                                                  leading: const Icon(Icons.people),
                                                                  title: Text("${data['name']}",style: const TextStyle(color: Colors.black),),
                                                                  subtitle: Text("${data['code']}",style: const TextStyle(color: Colors.black),),
                                                                ),
                                                              );
                                                            }).toList(),
                                                          );
                                                        },
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
                                    contentPadding: const EdgeInsets.all(15),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(7.0),
                                      borderSide: const BorderSide(
                                        color: primaryColor,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(7.0),
                                      borderSide: const BorderSide(
                                          color: primaryColor,
                                          width: 0.5
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(7.0),
                                      borderSide: const BorderSide(
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
                            const SizedBox(height: 20,),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Sub Group 2 Code",
                                  style: Theme.of(context).textTheme.bodyText1!.apply(color: Colors.black),
                                ),
                                TextFormField(
                                  style: const TextStyle(color: Colors.black),
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
                                                shape: const RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0),
                                                  ),
                                                ),
                                                insetAnimationDuration: const Duration(seconds: 1),
                                                insetAnimationCurve: Curves.fastOutSlowIn,
                                                elevation: 2,
                                                child: Container(
                                                  padding: const EdgeInsets.all(10),
                                                  height: MediaQuery.of(context).size.height*0.7,

                                                  width: MediaQuery.of(context).size.width*0.3,
                                                  child: ListView(
                                                    children: [
                                                      Container(
                                                        height: 50,
                                                        margin: const EdgeInsets.all(10),
                                                        child: TypeAheadField(
                                                          textFieldConfiguration: TextFieldConfiguration(


                                                            decoration: InputDecoration(
                                                              contentPadding: const EdgeInsets.all(15),
                                                              focusedBorder: OutlineInputBorder(
                                                                borderRadius: BorderRadius.circular(7.0),
                                                                borderSide: const BorderSide(
                                                                  color: Colors.transparent,
                                                                ),
                                                              ),
                                                              enabledBorder: OutlineInputBorder(
                                                                borderRadius: BorderRadius.circular(7.0),
                                                                borderSide: const BorderSide(
                                                                    color: Colors.transparent,
                                                                    width: 0.5
                                                                ),
                                                              ),
                                                              border: OutlineInputBorder(
                                                                borderRadius: BorderRadius.circular(7.0),
                                                                borderSide: const BorderSide(
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
                                                            return const ListTile(
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
                                                                if (model.code.contains(pattern))
                                                                  search.add(model);
                                                              });
                                                            });

                                                            return search;
                                                          },
                                                          itemBuilder: (context, MainGroupModel suggestion) {
                                                            return ListTile(
                                                              leading: const Icon(Icons.people),
                                                              title: Text(suggestion.name),
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
                                                      StreamBuilder<QuerySnapshot>(
                                                        stream: FirebaseFirestore.instance.collection('sub_group2').where("subGroup1Code",isEqualTo: subGroup1Code).snapshots(),
                                                        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                                          if (snapshot.hasError) {
                                                            return Center(
                                                              child: Column(
                                                                children: [
                                                                  Image.asset("assets/images/wrong.png",width: 150,height: 150,),
                                                                  const Text("Something Went Wrong",style: TextStyle(color: Colors.black))

                                                                ],
                                                              ),
                                                            );
                                                          }

                                                          if (snapshot.connectionState == ConnectionState.waiting) {
                                                            return const Center(
                                                              child: CircularProgressIndicator(),
                                                            );
                                                          }
                                                          if (snapshot.data!.size==0){
                                                            return Center(
                                                                child: Column(
                                                                  children: [
                                                                    SizedBox(height: 20,),
                                                                    Text("No Sub Group Added",style: TextStyle(color: Colors.black)),
                                                                    SizedBox(height: 10,),
                                                                    ElevatedButton.icon(
                                                                      style: TextButton.styleFrom(
                                                                        padding: EdgeInsets.symmetric(
                                                                          horizontal: defaultPadding * 1.5,
                                                                          vertical:
                                                                          defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                                                                        ),
                                                                      ),
                                                                      onPressed: ()async {
                                                                        SubGroupDialogs.showAdd2Dialog(context,2);
                                                                      },
                                                                      icon: const Icon(Icons.add),
                                                                      label: Text("Add Sub Group 2"),
                                                                    ),
                                                                  ],
                                                                )
                                                            );

                                                          }

                                                          return ListView(
                                                            physics: NeverScrollableScrollPhysics(),
                                                            shrinkWrap: true,
                                                            children: snapshot.data!.docs.map((DocumentSnapshot document) {
                                                              Map<String, dynamic> data = document.data() as Map<String, dynamic>;

                                                              return Padding(
                                                                padding: const EdgeInsets.only(top: 15.0),
                                                                child: ListTile(
                                                                  onTap: (){
                                                                    setState(() {
                                                                      subGroup2Code=data['code'];
                                                                      _subGroup2CodeController.text="${data['code']} - ${data['name']}";
                                                                    });
                                                                    Navigator.pop(context);
                                                                  },
                                                                  leading: const Icon(Icons.people),
                                                                  title: Text("${data['name']}",style: const TextStyle(color: Colors.black),),
                                                                  subtitle: Text("${data['code']}",style: const TextStyle(color: Colors.black),),
                                                                ),
                                                              );
                                                            }).toList(),
                                                          );
                                                        },
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
                                    contentPadding: const EdgeInsets.all(15),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(7.0),
                                      borderSide: const BorderSide(
                                        color: primaryColor,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(7.0),
                                      borderSide: const BorderSide(
                                          color: primaryColor,
                                          width: 0.5
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(7.0),
                                      borderSide: const BorderSide(
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
                            const SizedBox(height: 20,),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Sub Group 3 Code",
                                  style: Theme.of(context).textTheme.bodyText1!.apply(color: Colors.black),
                                ),
                                TextFormField(
                                  style: const TextStyle(color: Colors.black),
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
                                                shape: const RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0),
                                                  ),
                                                ),
                                                insetAnimationDuration: const Duration(seconds: 1),
                                                insetAnimationCurve: Curves.fastOutSlowIn,
                                                elevation: 2,
                                                child: Container(
                                                  padding: const EdgeInsets.all(10),
                                                  width: MediaQuery.of(context).size.width*0.3,
                                                  height: MediaQuery.of(context).size.height*0.7,
                                                  child: ListView(
                                                    children: [
                                                      Container(
                                                        height: 50,
                                                        margin: const EdgeInsets.all(10),
                                                        child: TypeAheadField(
                                                          textFieldConfiguration: TextFieldConfiguration(


                                                            decoration: InputDecoration(
                                                              contentPadding: const EdgeInsets.all(15),
                                                              focusedBorder: OutlineInputBorder(
                                                                borderRadius: BorderRadius.circular(7.0),
                                                                borderSide: const BorderSide(
                                                                  color: Colors.transparent,
                                                                ),
                                                              ),
                                                              enabledBorder: OutlineInputBorder(
                                                                borderRadius: BorderRadius.circular(7.0),
                                                                borderSide: const BorderSide(
                                                                    color: Colors.transparent,
                                                                    width: 0.5
                                                                ),
                                                              ),
                                                              border: OutlineInputBorder(
                                                                borderRadius: BorderRadius.circular(7.0),
                                                                borderSide: const BorderSide(
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
                                                            return const ListTile(
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
                                                                if (model.code.contains(pattern))
                                                                  search.add(model);
                                                              });
                                                            });

                                                            return search;
                                                          },
                                                          itemBuilder: (context, MainGroupModel suggestion) {
                                                            return ListTile(
                                                              leading: const Icon(Icons.people),
                                                              title: Text(suggestion.name),
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
                                                      StreamBuilder<QuerySnapshot>(
                                                        stream: FirebaseFirestore.instance.collection('sub_group3').where("subGroup2Code",isEqualTo: subGroup2Code).snapshots(),
                                                        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                                          if (snapshot.hasError) {
                                                            return Center(
                                                              child: Column(
                                                                children: [
                                                                  Image.asset("assets/images/wrong.png",width: 150,height: 150,),
                                                                  const Text("Something Went Wrong",style: TextStyle(color: Colors.black))

                                                                ],
                                                              ),
                                                            );
                                                          }

                                                          if (snapshot.connectionState == ConnectionState.waiting) {
                                                            return const Center(
                                                              child: CircularProgressIndicator(),
                                                            );
                                                          }
                                                          if (snapshot.data!.size==0){
                                                            return Center(
                                                                child: Column(
                                                                  children: [
                                                                    SizedBox(height: 20,),
                                                                    Text("No Sub Group Added",style: TextStyle(color: Colors.black)),
                                                                    SizedBox(height: 10,),
                                                                    ElevatedButton.icon(
                                                                      style: TextButton.styleFrom(
                                                                        padding: EdgeInsets.symmetric(
                                                                          horizontal: defaultPadding * 1.5,
                                                                          vertical:
                                                                          defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                                                                        ),
                                                                      ),
                                                                      onPressed: ()async {
                                                                        SubGroupDialogs.showAdd3Dialog(context,3);
                                                                      },
                                                                      icon: const Icon(Icons.add),
                                                                      label: Text("Add Sub Group 3"),
                                                                    ),
                                                                  ],
                                                                )
                                                            );

                                                          }

                                                          return ListView(
                                                            shrinkWrap: true,
                                                            physics: NeverScrollableScrollPhysics(),
                                                            children: snapshot.data!.docs.map((DocumentSnapshot document) {
                                                              Map<String, dynamic> data = document.data() as Map<String, dynamic>;

                                                              return Padding(
                                                                padding: const EdgeInsets.only(top: 15.0),
                                                                child: ListTile(
                                                                  onTap: (){
                                                                    setState(() {
                                                                      subGroup3Code=data['code'];
                                                                      _subGroup3CodeController.text="${data['code']} - ${data['name']}";
                                                                    });
                                                                    Navigator.pop(context);
                                                                  },
                                                                  leading: const Icon(Icons.people),
                                                                  title: Text("${data['name']}",style: const TextStyle(color: Colors.black),),
                                                                  subtitle: Text("${data['code']}",style: const TextStyle(color: Colors.black),),
                                                                ),
                                                              );
                                                            }).toList(),
                                                          );
                                                        },
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
                                    contentPadding: const EdgeInsets.all(15),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(7.0),
                                      borderSide: const BorderSide(
                                        color: primaryColor,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(7.0),
                                      borderSide: const BorderSide(
                                          color: primaryColor,
                                          width: 0.5
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(7.0),
                                      borderSide: const BorderSide(
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
                            const SizedBox(height: 20,),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Sub Group 4 Code",
                                  style: Theme.of(context).textTheme.bodyText1!.apply(color: Colors.black),
                                ),
                                TextFormField(
                                  style: const TextStyle(color: Colors.black),
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
                                                shape: const RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0),
                                                  ),
                                                ),
                                                insetAnimationDuration: const Duration(seconds: 1),
                                                insetAnimationCurve: Curves.fastOutSlowIn,
                                                elevation: 2,
                                                child: Container(
                                                  padding: const EdgeInsets.all(10),
                                                  width: MediaQuery.of(context).size.width*0.3,
                                                  height: MediaQuery.of(context).size.height*0.7,

                                                  child: ListView(
                                                    children: [
                                                      Container(
                                                        height: 50,
                                                        margin: const EdgeInsets.all(10),
                                                        child: TypeAheadField(
                                                          textFieldConfiguration: TextFieldConfiguration(


                                                            decoration: InputDecoration(
                                                              contentPadding: const EdgeInsets.all(15),
                                                              focusedBorder: OutlineInputBorder(
                                                                borderRadius: BorderRadius.circular(7.0),
                                                                borderSide: const BorderSide(
                                                                  color: Colors.transparent,
                                                                ),
                                                              ),
                                                              enabledBorder: OutlineInputBorder(
                                                                borderRadius: BorderRadius.circular(7.0),
                                                                borderSide: const BorderSide(
                                                                    color: Colors.transparent,
                                                                    width: 0.5
                                                                ),
                                                              ),
                                                              border: OutlineInputBorder(
                                                                borderRadius: BorderRadius.circular(7.0),
                                                                borderSide: const BorderSide(
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
                                                            return const ListTile(
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
                                                                if (model.code.contains(pattern))
                                                                  search.add(model);
                                                              });
                                                            });

                                                            return search;
                                                          },
                                                          itemBuilder: (context, MainGroupModel suggestion) {
                                                            return ListTile(
                                                              leading: const Icon(Icons.people),
                                                              title: Text(suggestion.name),
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
                                                      StreamBuilder<QuerySnapshot>(
                                                        stream: FirebaseFirestore.instance.collection('sub_group4').where("subGroup3Code",isEqualTo:subGroup3Code).snapshots(),
                                                        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                                          if (snapshot.hasError) {
                                                            return Center(
                                                              child: Column(
                                                                children: [
                                                                  Image.asset("assets/images/wrong.png",width: 150,height: 150,),
                                                                  const Text("Something Went Wrong",style: TextStyle(color: Colors.black))

                                                                ],
                                                              ),
                                                            );
                                                          }

                                                          if (snapshot.connectionState == ConnectionState.waiting) {
                                                            return const Center(
                                                              child: CircularProgressIndicator(),
                                                            );
                                                          }
                                                          if (snapshot.data!.size==0){
                                                            return Center(
                                                                child: Column(
                                                                  children: [
                                                                    SizedBox(height: 20,),
                                                                    Text("No Sub Group Added",style: TextStyle(color: Colors.black)),
                                                                    SizedBox(height: 10,),
                                                                    ElevatedButton.icon(
                                                                      style: TextButton.styleFrom(
                                                                        padding: EdgeInsets.symmetric(
                                                                          horizontal: defaultPadding * 1.5,
                                                                          vertical:
                                                                          defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                                                                        ),
                                                                      ),
                                                                      onPressed: ()async {
                                                                        SubGroupDialogs.showAdd4Dialog(context,4);
                                                                      },
                                                                      icon: const Icon(Icons.add),
                                                                      label: Text("Add Sub Group 4"),
                                                                    ),
                                                                  ],
                                                                )
                                                            );

                                                          }

                                                          return ListView(
                                                            shrinkWrap: true,
                                                            physics: NeverScrollableScrollPhysics(),
                                                            children: snapshot.data!.docs.map((DocumentSnapshot document) {
                                                              Map<String, dynamic> data = document.data() as Map<String, dynamic>;

                                                              return Padding(
                                                                padding: const EdgeInsets.only(top: 15.0),
                                                                child: ListTile(
                                                                  onTap: (){
                                                                    setState(() {
                                                                      subGroup4Code=data['code'];
                                                                      _subGroup4CodeController.text="${data['code']} - ${data['name']}";
                                                                    });
                                                                    Navigator.pop(context);
                                                                  },
                                                                  leading: const Icon(Icons.people),
                                                                  title: Text("${data['name']}",style: const TextStyle(color: Colors.black),),
                                                                  subtitle: Text("${data['code']}",style: const TextStyle(color: Colors.black),),
                                                                ),
                                                              );
                                                            }).toList(),
                                                          );
                                                        },
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
                                    contentPadding: const EdgeInsets.all(15),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(7.0),
                                      borderSide: const BorderSide(
                                        color: primaryColor,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(7.0),
                                      borderSide: const BorderSide(
                                          color: primaryColor,
                                          width: 0.5
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(7.0),
                                      borderSide: const BorderSide(
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
                            const SizedBox(height: 20,),
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
                                  style: const TextStyle(color: Colors.black),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(15),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(7.0),
                                      borderSide: const BorderSide(
                                        color: primaryColor,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(7.0),
                                      borderSide: const BorderSide(
                                          color: primaryColor,
                                          width: 0.5
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(7.0),
                                      borderSide: const BorderSide(
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
                            const SizedBox(height: 20,),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Father Name",
                                  style: Theme.of(context).textTheme.bodyText1!.apply(color: Colors.black),
                                ),
                                TextFormField(
                                  controller: _fatherNameController,
                                  style: const TextStyle(color: Colors.black),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(15),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(7.0),
                                      borderSide: const BorderSide(
                                        color: primaryColor,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(7.0),
                                      borderSide: const BorderSide(
                                          color: primaryColor,
                                          width: 0.5
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(7.0),
                                      borderSide: const BorderSide(
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
                            const SizedBox(height: 20,),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Display Name",
                                  style: Theme.of(context).textTheme.bodyText1!.apply(color: Colors.black),
                                ),
                                TextFormField(
                                    controller: _displayController,
                                  style: const TextStyle(color: Colors.black),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(15),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(7.0),
                                      borderSide: const BorderSide(
                                        color: primaryColor,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(7.0),
                                      borderSide: const BorderSide(
                                          color: primaryColor,
                                          width: 0.5
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(7.0),
                                      borderSide: const BorderSide(
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
                            const SizedBox(height: 20,),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "DOB",
                                  style: Theme.of(context).textTheme.bodyText1!.apply(color: Colors.black),
                                ),
                                TextFormField(
                                    controller: _dobController,
                                  readOnly: true,
                                  onTap: ()async{
                                    final DateTime? picked = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(1960, 1),
                                        lastDate: DateTime.now());
                                    if (picked != null) {
                                      setState(() {
                                        final f = DateFormat('dd-MM-yyyy');
                                        _dobController.text = f.format(picked);
                                      });
                                    }
                                  },
                                  style: const TextStyle(color: Colors.black),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(15),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(7.0),
                                      borderSide: const BorderSide(
                                        color: primaryColor,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(7.0),
                                      borderSide: const BorderSide(
                                          color: primaryColor,
                                          width: 0.5
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(7.0),
                                      borderSide: const BorderSide(
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
                            const SizedBox(height: 20,),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Landline",
                                  style: Theme.of(context).textTheme.bodyText1!.apply(color: Colors.black),
                                ),
                                TextFormField(
                                    controller: _landlineController,
                                  style: const TextStyle(color: Colors.black),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(15),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(7.0),
                                      borderSide: const BorderSide(
                                        color: primaryColor,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(7.0),
                                      borderSide: const BorderSide(
                                          color: primaryColor,
                                          width: 0.5
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(7.0),
                                      borderSide: const BorderSide(
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
                            const SizedBox(height: 20,),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Company Name",
                                  style: Theme.of(context).textTheme.bodyText1!.apply(color: Colors.black),
                                ),
                                TextFormField(
                                  controller: _companyController,
                                  style: const TextStyle(color: Colors.black),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(15),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(7.0),
                                      borderSide: const BorderSide(
                                        color: primaryColor,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(7.0),
                                      borderSide: const BorderSide(
                                          color: primaryColor,
                                          width: 0.5
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(7.0),
                                      borderSide: const BorderSide(
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
                            const SizedBox(height: 20,),
                            /*Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Job Description",
                                  style: Theme.of(context).textTheme.bodyText1!.apply(color: Colors.black),
                                ),
                                TextFormField(
                                  style: const TextStyle(color: Colors.black),
                                  validator: (value) {

                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                  controller: _jobdesController,
                                  readOnly: true,
                                  onTap: (){
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context){
                                          return StatefulBuilder(
                                            builder: (context,setState){
                                              return Dialog(
                                                shape: const RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0),
                                                  ),
                                                ),
                                                insetAnimationDuration: const Duration(seconds: 1),
                                                insetAnimationCurve: Curves.fastOutSlowIn,
                                                elevation: 2,
                                                child: Container(
                                                  padding: const EdgeInsets.all(10),
                                                  width: MediaQuery.of(context).size.width*0.3,
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        height: 50,
                                                        margin: const EdgeInsets.all(10),
                                                        child: TypeAheadField(
                                                          textFieldConfiguration: TextFieldConfiguration(


                                                            decoration: InputDecoration(
                                                              contentPadding: const EdgeInsets.all(15),
                                                              focusedBorder: OutlineInputBorder(
                                                                borderRadius: BorderRadius.circular(7.0),
                                                                borderSide: const BorderSide(
                                                                  color: Colors.transparent,
                                                                ),
                                                              ),
                                                              enabledBorder: OutlineInputBorder(
                                                                borderRadius: BorderRadius.circular(7.0),
                                                                borderSide: const BorderSide(
                                                                    color: Colors.transparent,
                                                                    width: 0.5
                                                                ),
                                                              ),
                                                              border: OutlineInputBorder(
                                                                borderRadius: BorderRadius.circular(7.0),
                                                                borderSide: const BorderSide(
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
                                                            return const ListTile(
                                                              leading: Icon(Icons.error),
                                                              title: Text("No Data Found"),
                                                            );
                                                          },
                                                          suggestionsCallback: (pattern) async {

                                                            List<MainGroupModel> search=[];
                                                            await FirebaseFirestore.instance
                                                                .collection('job_description')
                                                                .get()
                                                                .then((QuerySnapshot querySnapshot) {
                                                              querySnapshot.docs.forEach((doc) {
                                                                Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
                                                                MainGroupModel model=MainGroupModel.fromMap(data, doc.reference.id);
                                                                if (model.code.contains(pattern))
                                                                  search.add(model);
                                                              });
                                                            });

                                                            return search;
                                                          },
                                                          itemBuilder: (context, MainGroupModel suggestion) {
                                                            return ListTile(
                                                              leading: const Icon(Icons.people),
                                                              title: Text(suggestion.name),
                                                              subtitle: Text(suggestion.code),
                                                            );
                                                          },
                                                          onSuggestionSelected: (MainGroupModel suggestion) {
                                                            _jobdesController.text=suggestion.name;
                                                            Navigator.pop(context);

                                                          },
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: StreamBuilder<QuerySnapshot>(
                                                          stream: FirebaseFirestore.instance.collection('job_description').snapshots(),
                                                          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                                            if (snapshot.hasError) {
                                                              return Center(
                                                                child: Column(
                                                                  children: [
                                                                    Image.asset("assets/images/wrong.png",width: 150,height: 150,),
                                                                    const Text("Something Went Wrong",style: TextStyle(color: Colors.black))

                                                                  ],
                                                                ),
                                                              );
                                                            }

                                                            if (snapshot.connectionState == ConnectionState.waiting) {
                                                              return const Center(
                                                                child: CircularProgressIndicator(),
                                                              );
                                                            }
                                                            if (snapshot.data!.size==0){
                                                              return const Center(
                                                                  child: Text("No Data Added",style: TextStyle(color: Colors.black))
                                                              );

                                                            }

                                                            return ListView(
                                                              shrinkWrap: true,
                                                              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                                                                Map<String, dynamic> data = document.data() as Map<String, dynamic>;

                                                                return Padding(
                                                                  padding: const EdgeInsets.only(top: 15.0),
                                                                  child: ListTile(
                                                                    onTap: (){
                                                                      setState(() {
                                                                        _jobdesController.text="${data['name']}";
                                                                      });
                                                                      Navigator.pop(context);
                                                                    },
                                                                    leading: const Icon(Icons.people),
                                                                    title: Text("${data['name']}",style: const TextStyle(color: Colors.black),),
                                                                    subtitle: Text("${data['code']}",style: const TextStyle(color: Colors.black),),
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
                                    contentPadding: const EdgeInsets.all(15),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(7.0),
                                      borderSide: const BorderSide(
                                        color: primaryColor,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(7.0),
                                      borderSide: const BorderSide(
                                          color: primaryColor,
                                          width: 0.5
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(7.0),
                                      borderSide: const BorderSide(
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
                            const SizedBox(height: 20,),*/
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Occupation",
                                  style: Theme.of(context).textTheme.bodyText1!.apply(color: Colors.black),
                                ),
                                TextFormField(
                                  style: const TextStyle(color: Colors.black),
                                  validator: (value) {

                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                  controller: _occupationController,
                                  readOnly: true,
                                  onTap: (){
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context){
                                          return StatefulBuilder(
                                            builder: (context,setState){
                                              return Dialog(
                                                shape: const RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0),
                                                  ),
                                                ),
                                                insetAnimationDuration: const Duration(seconds: 1),
                                                insetAnimationCurve: Curves.fastOutSlowIn,
                                                elevation: 2,
                                                child: Container(
                                                  padding: const EdgeInsets.all(10),
                                                  width: MediaQuery.of(context).size.width*0.3,
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        height: 50,
                                                        margin: const EdgeInsets.all(10),
                                                        child: TypeAheadField(
                                                          textFieldConfiguration: TextFieldConfiguration(


                                                            decoration: InputDecoration(
                                                              contentPadding: const EdgeInsets.all(15),
                                                              focusedBorder: OutlineInputBorder(
                                                                borderRadius: BorderRadius.circular(7.0),
                                                                borderSide: const BorderSide(
                                                                  color: Colors.transparent,
                                                                ),
                                                              ),
                                                              enabledBorder: OutlineInputBorder(
                                                                borderRadius: BorderRadius.circular(7.0),
                                                                borderSide: const BorderSide(
                                                                    color: Colors.transparent,
                                                                    width: 0.5
                                                                ),
                                                              ),
                                                              border: OutlineInputBorder(
                                                                borderRadius: BorderRadius.circular(7.0),
                                                                borderSide: const BorderSide(
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
                                                            return const ListTile(
                                                              leading: Icon(Icons.error),
                                                              title: Text("No Data Found"),
                                                            );
                                                          },
                                                          suggestionsCallback: (pattern) async {

                                                            List<OccupationModel> search=[];
                                                            await FirebaseFirestore.instance
                                                                .collection('occupation')
                                                                .get()
                                                                .then((QuerySnapshot querySnapshot) {
                                                              querySnapshot.docs.forEach((doc) {
                                                                Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
                                                                OccupationModel model=OccupationModel.fromMap(data, doc.reference.id);
                                                                if (model.code.contains(pattern))
                                                                  search.add(model);
                                                              });
                                                            });

                                                            return search;
                                                          },
                                                          itemBuilder: (context, OccupationModel suggestion) {
                                                            return ListTile(
                                                              leading: const Icon(Icons.people),
                                                              title: Text(suggestion.name),
                                                              subtitle: Text(suggestion.code),
                                                            );
                                                          },
                                                          onSuggestionSelected: (OccupationModel suggestion) {
                                                            _occupationController.text=suggestion.name;
                                                            Navigator.pop(context);

                                                          },
                                                        ),
                                                      ),
                                                      Expanded(
                                                        child: StreamBuilder<QuerySnapshot>(
                                                          stream: FirebaseFirestore.instance.collection('occupation').snapshots(),
                                                          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                                            if (snapshot.hasError) {
                                                              return Center(
                                                                child: Column(
                                                                  children: [
                                                                    Image.asset("assets/images/wrong.png",width: 150,height: 150,),
                                                                    const Text("Something Went Wrong",style: TextStyle(color: Colors.black))

                                                                  ],
                                                                ),
                                                              );
                                                            }

                                                            if (snapshot.connectionState == ConnectionState.waiting) {
                                                              return const Center(
                                                                child: CircularProgressIndicator(),
                                                              );
                                                            }
                                                            if (snapshot.data!.size==0){
                                                              return const Center(
                                                                  child: Text("No Data Added",style: TextStyle(color: Colors.black))
                                                              );

                                                            }

                                                            return ListView(
                                                              shrinkWrap: true,
                                                              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                                                                Map<String, dynamic> data = document.data() as Map<String, dynamic>;

                                                                return Padding(
                                                                  padding: const EdgeInsets.only(top: 15.0),
                                                                  child: ListTile(
                                                                    onTap: (){
                                                                      setState(() {
                                                                        _occupationController.text="${data['name']}";
                                                                      });
                                                                      Navigator.pop(context);
                                                                    },
                                                                    leading: const Icon(Icons.people),
                                                                    title: Text("${data['name']}",style: const TextStyle(color: Colors.black),),
                                                                    subtitle: Text("${data['code']}",style: const TextStyle(color: Colors.black),),
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
                                    contentPadding: const EdgeInsets.all(15),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(7.0),
                                      borderSide: const BorderSide(
                                        color: primaryColor,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(7.0),
                                      borderSide: const BorderSide(
                                          color: primaryColor,
                                          width: 0.5
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(7.0),
                                      borderSide: const BorderSide(
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
                            /*Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "",
                                    style: Theme.of(context).textTheme.bodyText1!.apply(color: Colors.black),
                                  ),
                                  CheckboxListTile(
                                    value: additionalResponsibilityRequired,
                                    onChanged: (value){
                                      setState(() {
                                        //referer = value!;
                                      });
                                    },
                                    title: const Text("Additional Responsibility Required"),
                                    controlAffinity: ListTileControlAffinity.leading,
                                  ),


                                ]
                            ),
                            if(additionalResponsibilityRequired)
                              Column(
                                  children:[
                                    const SizedBox(height: 20,),
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Additional Responsibility",
                                          style: Theme.of(context).textTheme.bodyText1!.apply(color: Colors.black),
                                        ),
                                        TextFormField(
                                          style: const TextStyle(color: Colors.black),
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
                                                        shape: const RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.all(
                                                            Radius.circular(10.0),
                                                          ),
                                                        ),
                                                        insetAnimationDuration: const Duration(seconds: 1),
                                                        insetAnimationCurve: Curves.fastOutSlowIn,
                                                        elevation: 2,
                                                        child: Container(
                                                          padding: const EdgeInsets.all(10),
                                                          width: MediaQuery.of(context).size.width*0.3,
                                                          child: Column(
                                                            children: [
                                                              Container(
                                                                height: 50,
                                                                margin: const EdgeInsets.all(10),
                                                                child: TypeAheadField(
                                                                  textFieldConfiguration: TextFieldConfiguration(


                                                                    decoration: InputDecoration(
                                                                      contentPadding: const EdgeInsets.all(15),
                                                                      focusedBorder: OutlineInputBorder(
                                                                        borderRadius: BorderRadius.circular(7.0),
                                                                        borderSide: const BorderSide(
                                                                          color: Colors.transparent,
                                                                        ),
                                                                      ),
                                                                      enabledBorder: OutlineInputBorder(
                                                                        borderRadius: BorderRadius.circular(7.0),
                                                                        borderSide: const BorderSide(
                                                                            color: Colors.transparent,
                                                                            width: 0.5
                                                                        ),
                                                                      ),
                                                                      border: OutlineInputBorder(
                                                                        borderRadius: BorderRadius.circular(7.0),
                                                                        borderSide: const BorderSide(
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
                                                                    return const ListTile(
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
                                                                        if (model.code.contains(pattern))
                                                                          search.add(model);
                                                                      });
                                                                    });

                                                                    return search;
                                                                  },
                                                                  itemBuilder: (context, OccupationModel suggestion) {
                                                                    return ListTile(
                                                                      leading: const Icon(Icons.people),
                                                                      title: Text(suggestion.name),
                                                                      subtitle: Text(suggestion.code),
                                                                    );
                                                                  },
                                                                  onSuggestionSelected: (OccupationModel suggestion) {
                                                                    _addResController.text=suggestion.name;
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
                                                                            const Text("Something Went Wrong",style: TextStyle(color: Colors.black))

                                                                          ],
                                                                        ),
                                                                      );
                                                                    }

                                                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                                                      return const Center(
                                                                        child: CircularProgressIndicator(),
                                                                      );
                                                                    }
                                                                    if (snapshot.data!.size==0){
                                                                      return const Center(
                                                                          child: Text("No Data Added",style: TextStyle(color: Colors.black))
                                                                      );

                                                                    }

                                                                    return ListView(
                                                                      shrinkWrap: true,
                                                                      children: snapshot.data!.docs.map((DocumentSnapshot document) {
                                                                        Map<String, dynamic> data = document.data() as Map<String, dynamic>;

                                                                        return Padding(
                                                                          padding: const EdgeInsets.only(top: 15.0),
                                                                          child: ListTile(
                                                                            onTap: (){
                                                                              setState(() {
                                                                                additionalResponsibilityCode=data['code'];
                                                                                _addResController.text="${data['name']}";
                                                                              });
                                                                              Navigator.pop(context);
                                                                            },
                                                                            leading: const Icon(Icons.people),
                                                                            title: Text("${data['name']}",style: const TextStyle(color: Colors.black),),
                                                                            subtitle: Text("${data['code']}",style: const TextStyle(color: Colors.black),),
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
                                            contentPadding: const EdgeInsets.all(15),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(7.0),
                                              borderSide: const BorderSide(
                                                color: primaryColor,
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(7.0),
                                              borderSide: const BorderSide(
                                                  color: primaryColor,
                                                  width: 0.5
                                              ),
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(7.0),
                                              borderSide: const BorderSide(
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

                                  ]
                              ),

                            const SizedBox(height: 20,),

                            Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "",
                                    style: Theme.of(context).textTheme.bodyText1!.apply(color: Colors.black),
                                  ),
                                  CheckboxListTile(
                                    value: expatriates,
                                    onChanged: (value){
                                      setState(() {
                                        expatriates = value!;
                                      });
                                    },
                                    title: const Text("Expatriates"),
                                    controlAffinity: ListTileControlAffinity.leading,
                                  ),


                                ]
                            ),
                            if(expatriates)*/
                              Column(
                                  children: [
                                    const SizedBox(height: 20,),
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Working/Staying Country",
                                          style: Theme.of(context).textTheme.bodyText1!.apply(color: Colors.black),
                                        ),
                                        TextFormField(
                                          style: const TextStyle(color: Colors.black),
                                          validator: (value) {

                                            if (value == null || value.isEmpty) {
                                              return 'Please enter some text';
                                            }
                                            return null;
                                          },
                                          controller: _countryController,
                                          readOnly: true,
                                          onTap: (){
                                            showDialog(
                                                context: context,
                                                builder: (BuildContext context){
                                                  return StatefulBuilder(
                                                    builder: (context,setState){
                                                      return Dialog(
                                                        shape: const RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.all(
                                                            Radius.circular(10.0),
                                                          ),
                                                        ),
                                                        insetAnimationDuration: const Duration(seconds: 1),
                                                         insetAnimationCurve: Curves.fastOutSlowIn,
                                                        elevation: 2,
                                                        child: Container(
                                                          padding: const EdgeInsets.all(10),
                                                          width: MediaQuery.of(context).size.width*0.3,
                                                          height: MediaQuery.of(context).size.height*0.7,
                                                          child: ListView(
                                                            children: [
                                                              Container(
                                                                height: 50,
                                                                margin: const EdgeInsets.all(10),
                                                                child: TypeAheadField(
                                                                  textFieldConfiguration: TextFieldConfiguration(


                                                                    decoration: InputDecoration(
                                                                      contentPadding: const EdgeInsets.all(15),
                                                                      focusedBorder: OutlineInputBorder(
                                                                        borderRadius: BorderRadius.circular(7.0),
                                                                        borderSide: const BorderSide(
                                                                          color: Colors.transparent,
                                                                        ),
                                                                      ),
                                                                      enabledBorder: OutlineInputBorder(
                                                                        borderRadius: BorderRadius.circular(7.0),
                                                                        borderSide: const BorderSide(
                                                                            color: Colors.transparent,
                                                                            width: 0.5
                                                                        ),
                                                                      ),
                                                                      border: OutlineInputBorder(
                                                                        borderRadius: BorderRadius.circular(7.0),
                                                                        borderSide: const BorderSide(
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
                                                                    return const ListTile(
                                                                      leading: Icon(Icons.error),
                                                                      title: Text("No Data Found"),
                                                                    );
                                                                  },
                                                                  suggestionsCallback: (pattern) async {

                                                                    List<AttributeModel> search=[];
                                                                    await FirebaseFirestore.instance
                                                                        .collection('country')
                                                                        .get()
                                                                        .then((QuerySnapshot querySnapshot) {
                                                                      querySnapshot.docs.forEach((doc) {
                                                                        Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
                                                                        AttributeModel model=AttributeModel.fromMap(data, doc.reference.id);
                                                                        if (model.code.contains(pattern))
                                                                          search.add(model);
                                                                      });
                                                                    });

                                                                    return search;
                                                                  },
                                                                  itemBuilder: (context, AttributeModel suggestion) {
                                                                    return ListTile(
                                                                      leading: const Icon(Icons.people),
                                                                      title: Text(suggestion.name),
                                                                      subtitle: Text(suggestion.code),
                                                                    );
                                                                  },
                                                                  onSuggestionSelected: (AttributeModel suggestion) {
                                                                    _countryController.text=suggestion.name;
                                                                    Navigator.pop(context);

                                                                  },
                                                                ),
                                                              ),
                                                              StreamBuilder<QuerySnapshot>(
                                                                stream: FirebaseFirestore.instance.collection('country').snapshots(),
                                                                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                                                  if (snapshot.hasError) {
                                                                    return Center(
                                                                      child: Column(
                                                                        children: [
                                                                          Image.asset("assets/images/wrong.png",width: 150,height: 150,),
                                                                          const Text("Something Went Wrong",style: TextStyle(color: Colors.black))

                                                                        ],
                                                                      ),
                                                                    );
                                                                  }

                                                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                                                    return const Center(
                                                                      child: CircularProgressIndicator(),
                                                                    );
                                                                  }
                                                                  if (snapshot.data!.size==0){
                                                                    return const Center(
                                                                        child: Text("No Data Added",style: TextStyle(color: Colors.black))
                                                                    );

                                                                  }

                                                                  return ListView(
                                                                    shrinkWrap: true,
                                                                    physics: NeverScrollableScrollPhysics(),
                                                                    children: snapshot.data!.docs.map((DocumentSnapshot document) {
                                                                      Map<String, dynamic> data = document.data() as Map<String, dynamic>;

                                                                      return Padding(
                                                                        padding: const EdgeInsets.only(top: 15.0),
                                                                        child: ListTile(
                                                                          onTap: (){
                                                                            setState(() {
                                                                              _countryController.text="${data['name']}";
                                                                            });
                                                                            Navigator.pop(context);
                                                                          },
                                                                          leading: const Icon(Icons.people),
                                                                          title: Text("${data['name']}",style: const TextStyle(color: Colors.black),),
                                                                          subtitle: Text("${data['code']}",style: const TextStyle(color: Colors.black),),
                                                                        ),
                                                                      );
                                                                    }).toList(),
                                                                  );
                                                                },
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
                                            contentPadding: const EdgeInsets.all(15),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(7.0),
                                              borderSide: const BorderSide(
                                                color: primaryColor,
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(7.0),
                                              borderSide: const BorderSide(
                                                  color: primaryColor,
                                                  width: 0.5
                                              ),
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(7.0),
                                              borderSide: const BorderSide(
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
                                    const SizedBox(height: 20,),
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Working/Staying City",
                                          style: Theme.of(context).textTheme.bodyText1!.apply(color: Colors.black),
                                        ),
                                        TextFormField(
                                          style: const TextStyle(color: Colors.black),
                                          validator: (value) {

                                            if (value == null || value.isEmpty) {
                                              return 'Please enter some text';
                                            }
                                            return null;
                                          },
                                          controller: _locationController,
                                          readOnly: true,
                                          onTap: (){
                                            showDialog(
                                                context: context,
                                                builder: (BuildContext context){
                                                  return StatefulBuilder(
                                                    builder: (context,setState){
                                                      return Dialog(
                                                        shape: const RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.all(
                                                            Radius.circular(10.0),
                                                          ),
                                                        ),
                                                        insetAnimationDuration: const Duration(seconds: 1),
                                                        insetAnimationCurve: Curves.fastOutSlowIn,
                                                        elevation: 2,
                                                        child: Container(
                                                          padding: const EdgeInsets.all(10),
                                                          width: MediaQuery.of(context).size.width*0.3,
                                                          height: MediaQuery.of(context).size.height*0.7,
                                                          child: ListView(
                                                            children: [
                                                              Container(
                                                                height: 50,
                                                                margin: const EdgeInsets.all(10),
                                                                child: TypeAheadField(
                                                                  textFieldConfiguration: TextFieldConfiguration(


                                                                    decoration: InputDecoration(
                                                                      contentPadding: const EdgeInsets.all(15),
                                                                      focusedBorder: OutlineInputBorder(
                                                                        borderRadius: BorderRadius.circular(7.0),
                                                                        borderSide: const BorderSide(
                                                                          color: Colors.transparent,
                                                                        ),
                                                                      ),
                                                                      enabledBorder: OutlineInputBorder(
                                                                        borderRadius: BorderRadius.circular(7.0),
                                                                        borderSide: const BorderSide(
                                                                            color: Colors.transparent,
                                                                            width: 0.5
                                                                        ),
                                                                      ),
                                                                      border: OutlineInputBorder(
                                                                        borderRadius: BorderRadius.circular(7.0),
                                                                        borderSide: const BorderSide(
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
                                                                    return const ListTile(
                                                                      leading: Icon(Icons.error),
                                                                      title: Text("No Data Found"),
                                                                    );
                                                                  },
                                                                  suggestionsCallback: (pattern) async {

                                                                    List<AttributeModel> search=[];
                                                                    await FirebaseFirestore.instance
                                                                        .collection('location')
                                                                        .get()
                                                                        .then((QuerySnapshot querySnapshot) {
                                                                      querySnapshot.docs.forEach((doc) {
                                                                        Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
                                                                        AttributeModel model=AttributeModel.fromMap(data, doc.reference.id);
                                                                        if (model.code.contains(pattern))
                                                                          search.add(model);
                                                                      });
                                                                    });

                                                                    return search;
                                                                  },
                                                                  itemBuilder: (context, AttributeModel suggestion) {
                                                                    return ListTile(
                                                                      leading: const Icon(Icons.people),
                                                                      title: Text(suggestion.name),
                                                                      subtitle: Text(suggestion.code),
                                                                    );
                                                                  },
                                                                  onSuggestionSelected: (AttributeModel suggestion) {
                                                                    _locationController.text=suggestion.name;
                                                                    Navigator.pop(context);

                                                                  },
                                                                ),
                                                              ),
                                                              StreamBuilder<QuerySnapshot>(
                                                                stream: FirebaseFirestore.instance.collection('location').snapshots(),
                                                                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                                                  if (snapshot.hasError) {
                                                                    return Center(
                                                                      child: Column(
                                                                        children: [
                                                                          Image.asset("assets/images/wrong.png",width: 150,height: 150,),
                                                                          const Text("Something Went Wrong",style: TextStyle(color: Colors.black))

                                                                        ],
                                                                      ),
                                                                    );
                                                                  }

                                                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                                                    return const Center(
                                                                      child: CircularProgressIndicator(),
                                                                    );
                                                                  }
                                                                  if (snapshot.data!.size==0){
                                                                    return const Center(
                                                                        child: Text("No Data Added",style: TextStyle(color: Colors.black))
                                                                    );

                                                                  }

                                                                  return ListView(
                                                                    shrinkWrap: true,
                                                                    physics: NeverScrollableScrollPhysics(),
                                                                    children: snapshot.data!.docs.map((DocumentSnapshot document) {
                                                                      Map<String, dynamic> data = document.data() as Map<String, dynamic>;

                                                                      return Padding(
                                                                        padding: const EdgeInsets.only(top: 15.0),
                                                                        child: ListTile(
                                                                          onTap: (){
                                                                            setState(() {
                                                                              _locationController.text="${data['name']}";
                                                                            });
                                                                            Navigator.pop(context);
                                                                          },
                                                                          leading: const Icon(Icons.people),
                                                                          title: Text("${data['name']}",style: const TextStyle(color: Colors.black),),
                                                                          subtitle: Text("${data['code']}",style: const TextStyle(color: Colors.black),),
                                                                        ),
                                                                      );
                                                                    }).toList(),
                                                                  );
                                                                },
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
                                            contentPadding: const EdgeInsets.all(15),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(7.0),
                                              borderSide: const BorderSide(
                                                color: primaryColor,
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(7.0),
                                              borderSide: const BorderSide(
                                                  color: primaryColor,
                                                  width: 0.5
                                              ),
                                            ),
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(7.0),
                                              borderSide: const BorderSide(
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
                                  ],
                              ),

                            const SizedBox(height: 20,),
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
                                  style: const TextStyle(color: Colors.black),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(15),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(7.0),
                                      borderSide: const BorderSide(
                                        color: primaryColor,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(7.0),
                                      borderSide: const BorderSide(
                                          color: primaryColor,
                                          width: 0.5
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(7.0),
                                      borderSide: const BorderSide(
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
                            const SizedBox(height: 20,),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Password",
                                  style: Theme.of(context).textTheme.bodyText1!.apply(color: Colors.black),
                                ),
                                TextFormField(
                                    controller: _passwordController,
                                  style: const TextStyle(color: Colors.black),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(15),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(7.0),
                                      borderSide: const BorderSide(
                                        color: primaryColor,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(7.0),
                                      borderSide: const BorderSide(
                                          color: primaryColor,
                                          width: 0.5
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(7.0),
                                      borderSide: const BorderSide(
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
                            const SizedBox(height: 20,),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Confirm Password",
                                  style: Theme.of(context).textTheme.bodyText1!.apply(color: Colors.black),
                                ),
                                TextFormField(
                                  controller: _confirmPasswordController,
                                  style: const TextStyle(color: Colors.black),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter some text';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.all(15),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(7.0),
                                      borderSide: const BorderSide(
                                        color: primaryColor,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(7.0),
                                      borderSide: const BorderSide(
                                          color: primaryColor,
                                          width: 0.5
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(7.0),
                                      borderSide: const BorderSide(
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
                            const SizedBox(height: 20,),
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Mobile",
                                          style: Theme.of(context).textTheme.bodyText1!.apply(color: Colors.black),
                                        ),
                                        Row(
                                          children: [
                                            Center(
                                              child: CountryCodePicker(
                                                onChanged: (value){
                                                  phoneCode=value.dialCode!;
                                                },
                                                // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                                                initialSelection: 'PK',
                                                favorite: ['+92','PK'],
                                                // optional. Shows only country name and flag
                                                showCountryOnly: false,
                                                // optional. Shows only country name and flag when popup is closed.
                                                showOnlyCountryWhenClosed: false,
                                                // optional. aligns the flag and the Text left
                                                alignLeft: false,
                                              ),
                                            ),
                                            Expanded(
                                                child:TextFormField(
                                                  controller: _mobileController,
                                                  style: const TextStyle(color: Colors.black),
                                                  validator: (value) {
                                                    if (value == null || value.isEmpty) {
                                                      return 'Please enter some text';
                                                    }
                                                    return null;
                                                  },
                                                  decoration: InputDecoration(
                                                    contentPadding: const EdgeInsets.all(15),
                                                    focusedBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(7.0),
                                                      borderSide: const BorderSide(
                                                        color: primaryColor,
                                                      ),
                                                    ),
                                                    enabledBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(7.0),
                                                      borderSide: const BorderSide(
                                                          color: primaryColor,
                                                          width: 0.5
                                                      ),
                                                    ),
                                                    border: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(7.0),
                                                      borderSide: const BorderSide(
                                                        color: primaryColor,
                                                        width: 0.5,
                                                      ),
                                                    ),
                                                    hintText: "",
                                                    floatingLabelBehavior: FloatingLabelBehavior.always,
                                                  ),
                                                ),
                                            )
                                          ],
                                        ),

                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Gender",
                                          style: Theme.of(context).textTheme.bodyText1!.apply(color: Colors.black),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.only(left: 5,right: 5),
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
                            const SizedBox(height: 20,),
                            //
                            /*Column(
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
                                  title: const Text("Reffer To Friend"),
                                  controlAffinity: ListTileControlAffinity.leading,
                                  ),


                              ]
                            ),
                            const SizedBox(height: 20,),
                            Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "",
                                    style: Theme.of(context).textTheme.bodyText1!.apply(color: Colors.black),
                                  ),
                                  CheckboxListTile(
                                    value: active,
                                    onChanged: (value){
                                      setState(() {
                                        active = value!;
                                      });
                                    },
                                    title: const Text("Active"),
                                    controlAffinity: ListTileControlAffinity.leading,
                                  ),


                                ]
                            ),
                            const SizedBox(height: 20,),
                            Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "",
                                    style: Theme.of(context).textTheme.bodyText1!.apply(color: Colors.black),
                                  ),
                                  CheckboxListTile(
                                    value: groupCode,
                                    onChanged: (value){
                                      setState(() {
                                        groupCode = value!;
                                      });
                                    },
                                    title: const Text("Group Code"),
                                    controlAffinity: ListTileControlAffinity.leading,
                                  ),


                                ]
                            ),
                            const SizedBox(height: 20,),
                            Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "",
                                    style: Theme.of(context).textTheme.bodyText1!.apply(color: Colors.black),
                                  ),
                                  CheckboxListTile(
                                    value: sub1Representative,
                                    onChanged: (value){
                                      setState(() {
                                        sub1Representative = value!;
                                      });
                                    },
                                    title: const Text("Sub Group 1 Representative"),
                                    controlAffinity: ListTileControlAffinity.leading,
                                  ),


                                ]
                            ),
                            const SizedBox(height: 20,),
                            Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "",
                                    style: Theme.of(context).textTheme.bodyText1!.apply(color: Colors.black),
                                  ),
                                  CheckboxListTile(
                                    value: sub2Representative,
                                    onChanged: (value){
                                      setState(() {
                                        sub2Representative = value!;
                                      });
                                    },
                                    title: const Text("Sub Group 2 Representative"),
                                    controlAffinity: ListTileControlAffinity.leading,
                                  ),


                                ]
                            ),
                            const SizedBox(height: 20,),
                            Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "",
                                    style: Theme.of(context).textTheme.bodyText1!.apply(color: Colors.black),
                                  ),
                                  CheckboxListTile(
                                    value: sub3Representative,
                                    onChanged: (value){
                                      setState(() {
                                        sub3Representative = value!;
                                      });
                                    },
                                    title: const Text("Sub Group 3 Representative"),
                                    controlAffinity: ListTileControlAffinity.leading,
                                  ),


                                ]
                            ),
                            const SizedBox(height: 20,),
                            Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "",
                                    style: Theme.of(context).textTheme.bodyText1!.apply(color: Colors.black),
                                  ),
                                  CheckboxListTile(
                                    value: sub4Representative,
                                    onChanged: (value){
                                      setState(() {
                                        sub4Representative = value!;
                                      });
                                    },
                                    title: const Text("Sub Group 4 Representative"),
                                    controlAffinity: ListTileControlAffinity.leading,
                                  ),


                                ]
                            ),
                            const SizedBox(height: 10,),*/
                            InkWell(
                              onTap: ()async{
                                if(_formKey.currentState!.validate()){
                                  if(_passwordController.text==_confirmPasswordController.text){
                                    if(FirebaseAuth.instance.currentUser!=null){
                                      await FirebaseAuth.instance.signOut();
                                    }
                                    final ProgressDialog pr = ProgressDialog(context: context);
                                    //FirebaseApp app = await Firebase.initializeApp(name: 'Secondary', options: Firebase.app().options);
                                    pr.show(max: 100, msg: "Please wait");
                                    await FirebaseAuth.instance.createUserWithEmailAndPassword(
                                        email: _emailController.text.trim(),
                                        password: _passwordController.text
                                    ).then((value){
                                      FirebaseFirestore.instance.collection('users').doc(value.user!.uid).set({

                                        "email":_emailController.text,
                                        "password":_passwordController.text,
                                        "name":_nameController.text,
                                        "displayName":_displayController.text,
                                        "fatherName":_fatherNameController.text,
                                        "dob":_dobController.text,
                                        "landline":_landlineController.text,
                                        "mobile":'${phoneCode}${_mobileController.text}',
                                        "occupation":_occupationController.text,
                                        "jobDescription":_jobdesController.text,
                                        "additionalResponsibility":_addResController.text,
                                        "companyName":_companyController.text,
                                        "gender":dropdownValue,
                                        "country":_countryController.text,
                                        "additionalResponsibilityCode":additionalResponsibilityCode,
                                        "location":_locationController.text,
                                        "mainGroup":_mainGroupCodeController.text,
                                         "mainGroupCode":mainGroupCode,
                                        "subGroup1":_subGroup1CodeController.text,
                                        "subGroup1Representative":sub1Representative,
                                        "subGroup1Code":subGroup1Code,
                                        "subGroup2":_subGroup2CodeController.text,
                                        "subGroup2Representative":sub2Representative,
                                        "subGroup2Code":subGroup2Code,
                                        "subGroup3":_subGroup3CodeController.text,
                                        "subGroup3Representative":sub3Representative,
                                        "subGroup3Code":subGroup3Code,
                                        "subGroup4":_subGroup4CodeController.text,
                                        "subGroup4Representative":sub4Representative,
                                        "subGroup4Code":subGroup4Code,
                                        "group":groupCode,
                                        "action":active,
                                        "refer":referer,
                                        "expatriates":expatriates,
                                        "additionalResponsibilityRequired":additionalResponsibilityRequired,
                                        "status":"Active",
                                        "createdAt":DateTime.now().millisecondsSinceEpoch,
                                        "token":"",
                                        "country_main":false,
                                        "country_sub1":false,
                                        "country_sub2":false,
                                        "country_sub3":false,
                                        "country_sub4":false,
                                        "country_occupation":false,
                                        "country_restype":false,
                                        "city_main":false,
                                        "city_sub1":false,
                                        "city_sub2":false,
                                        "city_sub3":true,
                                        "city_sub4":true,
                                        "city_occupation":true,
                                        "city_restype":true,

                                      }).then((value) {
                                        pr.close();
                                        print('value id');
                                        //Navigator.pop(context);
                                      }).onError((error, stackTrace){
                                        pr.close();
                                        CoolAlert.show(
                                          context: context,
                                          type: CoolAlertType.error,
                                          text: error.toString(),
                                        );
                                      });
                                    }).onError((error, stackTrace){
                                      pr.close();
                                      CoolAlert.show(
                                        context: context,
                                        type: CoolAlertType.error,
                                        text: error.toString(),
                                      );
                                    });

                                    //await app.delete();
                                  }
                                  else{
                                    CoolAlert.show(
                                      context: context,
                                      type: CoolAlertType.error,
                                      text: "Password do not match",
                                    );
                                  }
                                }
                              },
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  color: primaryColor,
                                ),
                                alignment: Alignment.center,
                                child: Text("Add User",style: Theme.of(context).textTheme.button!.apply(color: Colors.white),),
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
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Header("Users",widget._scaffoldKey),
            const SizedBox(height: defaultPadding),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [

                          ElevatedButton.icon(
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                horizontal: defaultPadding * 1.5,
                                vertical:
                                defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                              ),
                            ),
                            onPressed: ()async {
                              _showAddDialog();
                            },
                            icon: const Icon(Icons.add),
                            label: const Text("Add User"),
                          ),
                          SizedBox(width: 10,),
                          /*ElevatedButton.icon(
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                horizontal: defaultPadding * 1.5,
                                vertical:
                                defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                              ),
                            ),
                            onPressed: ()async {
                              var picked = await FilePicker.platform.pickFiles(allowedExtensions: ['csv'],type: FileType.custom);

                              if (picked != null) {
                                print(picked.files.first.name);
                                List<int> bytes = picked.files.first.bytes!;
                                String csvString = String.fromCharCodes(bytes);
                                List<List<dynamic>> parsedCSV = CsvToListConverter().convert(csvString);
                                print('pl ${parsedCSV}');
                                List<OccupationModel> list=[];
                                parsedCSV.forEach((element) {
                                  OccupationModel model=OccupationModel(
                                      '',
                                      element[1].toString(),
                                      '',
                                      element[2].toString(),
                                      0

                                  );
                                  //if(coaches.length<10)
                                  list.add(model);

                                });
                                for (var element in list) {
                                  if (element.name!='Name') {
                                    int count=0;
                                    await FirebaseFirestore.instance.collection('occupation')
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
                                    await FirebaseFirestore.instance.collection('occupation').add({
                                      "code":subCode,
                                      "codeCount":count,
                                      "name":element.name,
                                      "type":element.type,
                                      "status":"Active",
                                      "createdAt":DateTime.now().millisecondsSinceEpoch,
                                    });
                                  }


                                }



                              }

                            },
                            icon: const Icon(Icons.upload),
                            label: const Text("Import"),
                          ),
                          SizedBox(width: 10,),*/
                          ElevatedButton.icon(
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                horizontal: defaultPadding * 1.5,
                                vertical:
                                defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                              ),
                            ),
                            onPressed: ()async {
                              List<String> rowHeader = ["Display Name","Name",'Father Name','Email','Mobile','Landline','Company','DOB','Occupation','City','Country','Gender'
                                ,'Main Group','Sub Group 1','Sub Group 2','Sub Group 3','Sub Group 4'
                                ,'Sub Group 1 Representative','Sub Group 2 Representative','Sub Group 3 Representative','Sub Group 4 Representative'];
                              List<List<dynamic>> rows = [];
                              List<UserModel> list=await FirebaseApi.getAllUsers();
                              rows.add(rowHeader);
                              for(int i=0;i<list.length;i++){
                                List<dynamic> dataRow=[];
                                dataRow.add(list[i].displayName);
                                dataRow.add(list[i].name);
                                dataRow.add(list[i].fatherName);
                                dataRow.add(list[i].email);
                                dataRow.add(list[i].mobile);
                                dataRow.add(list[i].landline);
                                dataRow.add(list[i].companyName);
                                dataRow.add(list[i].dob);
                                dataRow.add(list[i].occupation);
                                dataRow.add(list[i].location);
                                dataRow.add(list[i].country);
                                dataRow.add(list[i].gender);
                                dataRow.add(list[i].mainGroup);
                                dataRow.add(list[i].subGroup1);
                                dataRow.add(list[i].subGroup2);
                                dataRow.add(list[i].subGroup3);
                                dataRow.add(list[i].subGroup4);
                                dataRow.add(list[i].subGroup1Representative);
                                dataRow.add(list[i].subGroup2Representative);
                                dataRow.add(list[i].subGroup3Representative);
                                dataRow.add(list[i].subGroup4Representative);
                                rows.add(dataRow);
                              }
                              String csv = const ListToCsvConverter().convert(rows);
                              Uint8List bytes = Uint8List.fromList(utf8.encode(csv));

                              await FileSaver.instance.saveFile(
                                name: 'occupations',
                                bytes: bytes,
                                ext: 'csv',
                                mimeType: MimeType.csv,
                              );


                            },
                            icon: const Icon(Icons.download),
                            label: const Text("Export"),
                          ),
                        ],
                      ),

                      const SizedBox(height: defaultPadding),
                      const UserList(),
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

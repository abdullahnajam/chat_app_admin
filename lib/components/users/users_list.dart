import 'dart:html';
import 'dart:ui' as UI;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
import '../../data/firebase_api.dart';
import '../../model/attributes_model.dart';
import '../../model/main_group_model.dart';
import '../../model/occupation_model.dart';
import '../../model/user_model.dart';
import '../../utils/constants.dart';
import '../../utils/responsive.dart';
class UserList extends StatefulWidget {
  const UserList({Key? key}) : super(key: key);

  @override
  _UserListState createState() => _UserListState();
}


class _UserListState extends State<UserList> {
  String filter='Name';
  String query='';
  var _controller=TextEditingController();

  Future<void> _showEditDialog(UserModel model) async {


    var _nameController=TextEditingController();
    var _mobileController=TextEditingController();


    _nameController.text=model.name;
    _mobileController.text=model.mobile;
    String dropdownValue=model.gender;


    var _dobController=TextEditingController();
    var _landlineController=TextEditingController();
    var _fatherNameController=TextEditingController();

    _dobController.text=model.dob;
    _landlineController.text=model.landline;
    _fatherNameController.text=model.fatherName;

    var _occupationController=TextEditingController();
    var _jobdesController=TextEditingController();
    //var _resTypeController=TextEditingController();
    var _addResController=TextEditingController();
    var _countryController=TextEditingController();
    var _locationController=TextEditingController();
    var _displayController=TextEditingController();
    var _companyController=TextEditingController();

    _occupationController.text=model.occupation;
    _jobdesController.text=model.jobDescription;
    //_resTypeController.text=model.res_type;
    _addResController.text=model.additionalResponsibility;
    _countryController.text=model.country;
    _locationController.text=model.location;
    _displayController.text=model.displayName;
    _companyController.text=model.companyName;



    var _mainGroupCodeController=TextEditingController();
    var _subGroup1CodeController=TextEditingController();
    var _subGroup2CodeController=TextEditingController();
    var _subGroup3CodeController=TextEditingController();
    var _subGroup4CodeController=TextEditingController();

    _mainGroupCodeController.text=model.mainGroup;
    _subGroup1CodeController.text=model.subGroup1;
    _subGroup2CodeController.text=model.subGroup2;
    _subGroup3CodeController.text=model.subGroup3;
    _subGroup4CodeController.text=model.subGroup4;

    String mainGroupCode=model.mainGroupCode;
    String subGroup1Code=model.subGroup1Code;
    String subGroup2Code=model.subGroup2Code;
    String subGroup3Code=model.subGroup3Code;
    String subGroup4Code=model.subGroup4Code;
    String additionalResponsibilityCode=model.additionalResponsibilityCode;

    bool referer=model.refer;
    bool active=model.action;
    bool additionalResponsibilityRequired=model.additionalResponsibilityRequired;
    bool expatriates=model.expatriates;
    bool groupCode=model.group;
    bool sub1Representative=model.subGroup1Representative;
    bool sub2Representative=model.subGroup2Representative;
    bool sub3Representative=model.subGroup3Representative;
    bool sub4Representative=model.subGroup4Representative;


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
                                child: Text("EDIT USER",textAlign: TextAlign.center,style: Theme.of(context).textTheme.headline5!.apply(color: Colors.white),),
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
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                                                    if (model.code.contains(pattern)) {
                                                                      search.add(model);
                                                                    }
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
                                                                    if (model.code.contains(pattern)) {
                                                                      search.add(model);
                                                                    }
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
                                                                return const Center(
                                                                    child: Text("No Sub Group Added",style: TextStyle(color: Colors.black))
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
                                                                    .collection('sub_group2').where("subGroup1Code",isEqualTo: subGroup1Code)
                                                                    .get()
                                                                    .then((QuerySnapshot querySnapshot) {
                                                                  querySnapshot.docs.forEach((doc) {
                                                                    Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
                                                                    MainGroupModel model=MainGroupModel.fromMap(data, doc.reference.id);
                                                                    if (model.code.contains(pattern)) {
                                                                      search.add(model);
                                                                    }
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
                                                                return const Center(
                                                                    child: Text("No Sub Group Added",style: TextStyle(color: Colors.black))
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
                                                                    if (model.code.contains(pattern)) {
                                                                      search.add(model);
                                                                    }
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
                                                                return const Center(
                                                                    child: Text("No Sub Group Added",style: TextStyle(color: Colors.black))
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
                                                                    if (model.code.contains(pattern)) {
                                                                      search.add(model);
                                                                    }
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
                                                                return const Center(
                                                                    child: Text("No Sub Group Added",style: TextStyle(color: Colors.black))
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
                                  "Company",
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
                            Column(
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

                                                            List<MainGroupModel> search=[];
                                                            await FirebaseFirestore.instance
                                                                .collection('job_description')
                                                                .get()
                                                                .then((QuerySnapshot querySnapshot) {
                                                              querySnapshot.docs.forEach((doc) {
                                                                Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
                                                                MainGroupModel model=MainGroupModel.fromMap(data, doc.reference.id);
                                                                if (model.code.contains(pattern)) {
                                                                  search.add(model);
                                                                }
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
                                                      StreamBuilder<QuerySnapshot>(
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
                                                            physics: NeverScrollableScrollPhysics(),
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

                                                            List<OccupationModel> search=[];
                                                            await FirebaseFirestore.instance
                                                                .collection('occupation')
                                                                .get()
                                                                .then((QuerySnapshot querySnapshot) {
                                                              querySnapshot.docs.forEach((doc) {
                                                                Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
                                                                OccupationModel model=OccupationModel.fromMap(data, doc.reference.id);
                                                                if (model.code.contains(pattern)) {
                                                                  search.add(model);
                                                                }
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
                                                      StreamBuilder<QuerySnapshot>(
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
                                                            physics: NeverScrollableScrollPhysics(),
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

                            /*Column(
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
                                                                if (model.code.contains(pattern)) {
                                                                  search.add(model);
                                                                }
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
                            const SizedBox(height: 20,),
                            *//*Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Additional Responsibility Type",
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
                                  controller: _resTypeController,
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

                                                            List<AttributeModel> search=[];
                                                            await FirebaseFirestore.instance
                                                                .collection('res_type')
                                                                .get()
                                                                .then((QuerySnapshot querySnapshot) {
                                                              querySnapshot.docs.forEach((doc) {
                                                                Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
                                                                AttributeModel model=AttributeModel.fromMap(data, doc.reference.id);
                                                                if (model.code.contains(pattern)) {
                                                                  search.add(model);
                                                                }
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
                                                            _resTypeController.text=suggestion.name;
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
                                                                        _resTypeController.text="${data['name']}";
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
                            const SizedBox(height: 20,),*//*
                            Column(
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
                            *//*if(additionalResponsibilityRequired)
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
                                                                        if (model.code.contains(pattern)) {
                                                                          search.add(model);
                                                                        }
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
                                    const SizedBox(height: 20,),
                                    Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Additional Responsibility Type",
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
                                          controller: _resTypeController,
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

                                                                    List<AttributeModel> search=[];
                                                                    await FirebaseFirestore.instance
                                                                        .collection('res_type')
                                                                        .get()
                                                                        .then((QuerySnapshot querySnapshot) {
                                                                      querySnapshot.docs.forEach((doc) {
                                                                        Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
                                                                        AttributeModel model=AttributeModel.fromMap(data, doc.reference.id);
                                                                        if (model.code.contains(pattern)) {
                                                                          search.add(model);
                                                                        }
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
                                                                    _resTypeController.text=suggestion.name;
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
                                                                                _resTypeController.text="${data['name']}";
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
                              ),*//*
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
                                        //referer = value!;
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
                                                                      if (model.code.contains(pattern)) {
                                                                        search.add(model);
                                                                      }
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
                                                                      if (model.code.contains(pattern)) {
                                                                        search.add(model);
                                                                      }
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
                                        TextFormField(
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
                            const SizedBox(height: 30,),

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
                            const SizedBox(height: 10,),
                            InkWell(
                              onTap: ()async{
                                if(_formKey.currentState!.validate()){
                                  final ProgressDialog pr = ProgressDialog(context: context);
                                  pr.show(max: 100, msg: "Please wait");
                                  FirebaseFirestore.instance.collection('users').doc(model.id).update({

                                    "name":_nameController.text,
                                    "displayName":_displayController.text,
                                    "fatherName":_fatherNameController.text,
                                    "dob":_dobController.text,
                                    "landline":_landlineController.text,
                                    "mobile":_mobileController.text,
                                    "occupation":_occupationController.text,
                                    "jobDescription":_jobdesController.text,
                                    //"res_type":_resTypeController.text,
                                    "additionalResponsibility":_addResController.text,
                                    "additionalResponsibilityCode":additionalResponsibilityCode,
                                    "gender":dropdownValue,
                                    "country":_countryController.text,

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
                                    "companyName":_companyController.text,
                                    "subGroup4Representative":sub4Representative,
                                    "subGroup4Code":subGroup4Code,
                                    "group":groupCode,
                                    "action":active,
                                    "refer":referer,
                                    "expatriates":expatriates,
                                    "additionalResponsibilityRequired":additionalResponsibilityRequired,
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

  Future<void> _showSubGroupsDialog(UserModel model) async {


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
                              child: Text("SUB GROUPS",textAlign: TextAlign.center,style: Theme.of(context).textTheme.headline5!.apply(color: Colors.white),),
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
                          children: [
                            ListTile(
                              leading: const Icon(Icons.people),
                              title: Text(model.subGroup1),
                            ),
                            ListTile(
                              leading: const Icon(Icons.people),
                              title: Text(model.subGroup2),
                            ),
                            ListTile(
                              leading: const Icon(Icons.people),
                              title: Text(model.subGroup3),
                            ),
                            ListTile(
                              leading: const Icon(Icons.people),
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

  Future<void> _showAccessDialog(UserModel model) async {
    bool country_main=model.country_main;
    bool country_sub1=model.country_sub1;
    bool country_sub2=model.country_sub2;
    bool country_sub3=model.country_sub3;
    bool country_sub4=model.country_sub4;
    bool country_occupation=model.country_occupation;
    bool country_restype=model.country_restype;
    bool city_main=model.city_main;
    bool city_sub1=model.city_sub1;
    bool city_sub2=model.city_sub2;
    bool city_sub3=model.city_sub3;
    bool city_sub4=model.city_sub4;
    bool city_occupation=model.city_occupation;
    bool city_restype=model.city_restype;

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
                height: MediaQuery.of(context).size.height*0.7,
                width: Responsive.isMobile(context)?MediaQuery.of(context).size.width*0.7:MediaQuery.of(context).size.width*0.3,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)
                ),
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
                              child: Text("GROUP ACCESS",textAlign: TextAlign.center,style: Theme.of(context).textTheme.headline5!.apply(color: Colors.white),),
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
                          children: [
                            CheckboxListTile(
                              value: country_main,
                              onChanged: (bool? value)async{
                                await FirebaseFirestore.instance.collection('users').doc(model.id).update({
                                  "country_main":value!,
                                });
                                setState(() {
                                  country_main=value;
                                });
                              },
                              title: const Text("Resident Country + Main Group"),
                              controlAffinity: ListTileControlAffinity.leading,
                            ),
                            CheckboxListTile(
                              value: country_sub1,
                              onChanged: (bool? value)async{
                                await FirebaseFirestore.instance.collection('users').doc(model.id).update({
                                  "country_sub1":value!,
                                });
                                setState(() {
                                  country_sub1=value;
                                });
                              },
                              title: const Text("Resident Country + Sub Group 1"),
                              controlAffinity: ListTileControlAffinity.leading,
                            ),
                            CheckboxListTile(
                              value: country_sub2,
                              onChanged: (bool? value)async{
                                await FirebaseFirestore.instance.collection('users').doc(model.id).update({
                                  "country_sub2":value!,
                                });
                                setState(() {
                                  country_sub2=value;
                                });
                              },
                              title: const Text("Resident Country + Sub Group 2"),
                              controlAffinity: ListTileControlAffinity.leading,
                            ),
                            CheckboxListTile(
                              value: country_sub3,
                              onChanged: (bool? value)async{
                                await FirebaseFirestore.instance.collection('users').doc(model.id).update({
                                  "country_sub3":value!,
                                });
                                setState(() {
                                  country_sub3=value;
                                });
                              },
                              title: const Text("Resident Country + Sub Group 3"),
                              controlAffinity: ListTileControlAffinity.leading,
                            ),
                            CheckboxListTile(
                              value: country_sub4,
                              onChanged: (bool? value)async{
                                await FirebaseFirestore.instance.collection('users').doc(model.id).update({
                                  "country_sub4":value!,
                                });
                                setState(() {
                                  country_sub4=value;
                                });
                              },
                              title: const Text("Resident Country + Sub Group 4"),
                              controlAffinity: ListTileControlAffinity.leading,
                            ),
                            CheckboxListTile(
                              value: country_occupation,
                              onChanged: (bool? value)async{
                                await FirebaseFirestore.instance.collection('users').doc(model.id).update({
                                  "country_occupation":value!,
                                });
                                setState(() {
                                  country_occupation=value;
                                });
                              },
                              title: const Text("Resident Country + Occupation"),
                              controlAffinity: ListTileControlAffinity.leading,
                            ),
                            CheckboxListTile(
                              value: country_restype,
                              onChanged: (bool? value)async{
                                await FirebaseFirestore.instance.collection('users').doc(model.id).update({
                                  "country_restype":value!,
                                });
                                setState(() {
                                  country_restype=value;
                                });
                              },
                              title: const Text("Resident Country + Additional Responsibility"),
                              controlAffinity: ListTileControlAffinity.leading,
                            ),

                            //City

                            CheckboxListTile(
                              value: city_main,
                              onChanged: (bool? value)async{
                                await FirebaseFirestore.instance.collection('users').doc(model.id).update({
                                  "city_main":value!,
                                });
                                setState(() {
                                  city_main=value;
                                });
                              },
                              title: const Text("Resident City + Main Group"),
                              controlAffinity: ListTileControlAffinity.leading,
                            ),
                            CheckboxListTile(
                              value: city_sub1,
                              onChanged: (bool? value)async{
                                await FirebaseFirestore.instance.collection('users').doc(model.id).update({
                                  "city_sub1":value!,
                                });
                                setState(() {
                                  city_sub1=value;
                                });
                              },
                              title: const Text("Resident City + Sub Group 1"),
                              controlAffinity: ListTileControlAffinity.leading,
                            ),
                            CheckboxListTile(
                              value: city_sub2,
                              onChanged: (bool? value)async{
                                await FirebaseFirestore.instance.collection('users').doc(model.id).update({
                                  "city_sub2":value!,
                                });
                                setState(() {
                                  city_sub2=value;
                                });
                              },
                              title: const Text("Resident City + Sub Group 2"),
                              controlAffinity: ListTileControlAffinity.leading,
                            ),
                            CheckboxListTile(
                              value: city_sub3,
                              onChanged: (bool? value)async{
                                await FirebaseFirestore.instance.collection('users').doc(model.id).update({
                                  "city_sub3":value!,
                                });
                                setState(() {
                                  city_sub3=value;
                                });
                              },
                              title: const Text("Resident City + Sub Group 3"),
                              controlAffinity: ListTileControlAffinity.leading,
                            ),
                            CheckboxListTile(
                              value: city_sub4,
                              onChanged: (bool? value)async{
                                await FirebaseFirestore.instance.collection('users').doc(model.id).update({
                                  "city_sub4":value!,
                                });
                                setState(() {
                                  city_sub4=value;
                                });
                              },
                              title: const Text("Resident City + Sub Group 4"),
                              controlAffinity: ListTileControlAffinity.leading,
                            ),
                            CheckboxListTile(
                              value: city_occupation,
                              onChanged: (bool? value)async{
                                await FirebaseFirestore.instance.collection('users').doc(model.id).update({
                                  "city_occupation":value!,
                                });
                                setState(() {
                                  city_occupation=value;
                                });
                              },
                              title: const Text("Resident City + Occupation"),
                              controlAffinity: ListTileControlAffinity.leading,
                            ),
                            CheckboxListTile(
                              value: city_restype,
                              onChanged: (bool? value)async{
                                await FirebaseFirestore.instance.collection('users').doc(model.id).update({
                                  "city_restype":value!,
                                });
                                setState(() {
                                  city_restype=value;
                                });
                              },
                              title: const Text("Resident City + Additional Responsibility"),
                              controlAffinity: ListTileControlAffinity.leading,
                            ),


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
        height: MediaQuery.of(context).size.height*0.8,
        width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(defaultPadding),
      decoration: const BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
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
                      items: ['Name','Email','Mobile','City','Country'].map<DropdownMenuItem<String>>((String value) {
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
                          minWidth: 3000,
                          columns: const [
                            DataColumn(
                              label: Text("ID"),
                            ),
                            DataColumn(
                              label: Text("Group Access"),
                            ),

                            DataColumn(
                              label: Text("Display Name"),
                            ),
                            DataColumn(
                              label: Text("Name"),
                            ),

                            DataColumn(
                              label: Text("Father Name"),
                            ),
                            DataColumn(
                              label: Text("Email"),
                            ),
                            DataColumn(
                              label: Text("Password"),
                            ),
                            DataColumn(
                              label: Text("Mobile"),
                            ),
                            DataColumn(
                              label: Text("Landline"),
                            ),
                            DataColumn(
                              label: Text("Company"),
                            ),
                            DataColumn(
                              label: Text("DOB"),
                            ),
                            DataColumn(
                              label: Text("Occupation"),
                            ),
                            /*DataColumn(
                              label: Text("Job Description"),
                            ),
                            DataColumn(
                              label: Text('Additional\nResponsibility\nRequired'),
                            ),
                            DataColumn(
                              label: Text("Additional\nResponsibility\nCode"),
                            ),
                            DataColumn(
                              label: Text("Additional\nResponsibility\nType"),
                            ),
                            DataColumn(
                              label: Text("Expatriates"),
                            ),*/
                            DataColumn(
                              label: Text("Location"),
                            ),
                            DataColumn(
                              label: Text("Country"),
                            ),
                            DataColumn(
                              label: Text("Gender"),
                            ),
                            DataColumn(
                              label: Text("Group"),
                            ),
                            DataColumn(
                              label: Text("Sub Group"),
                            ),
                            DataColumn(
                              label: Text("Refer to Friend"),
                            ),
                            DataColumn(
                              label: Text("Action"),
                            ),
                            DataColumn(
                              label: Text("Group Code"),
                            ),
                            DataColumn(
                              label: Text("SubGroup 1\nRepresentative"),
                            ),
                            DataColumn(
                              label: Text("SubGroup 2\nRepresentative"),
                            ),
                            DataColumn(
                              label: Text("SubGroup 3\nRepresentative"),
                            ),
                            DataColumn(
                              label: Text("SubGroup 4\nRepresentative"),
                            ),
                            DataColumn(
                              label: Text("Actions"),
                            ),


                          ],
                          rows:  List<DataRow>.generate(snapshot.data!.length, (index){
                            return DataRow(
                                cells: [
                                  DataCell(
                                    Text(snapshot.data![index].id),
                                  ),
                                  DataCell(
                                      InkWell(
                                        onTap: (){
                                          _showAccessDialog(snapshot.data![index]);
                                        },
                                        child: const Text("Manage",style: TextStyle(color: primaryColor),),
                                      )
                                  ),
                                  DataCell(
                                    Text(snapshot.data![index].displayName),
                                  ),
                                  DataCell(
                                    Text(snapshot.data![index].name),
                                  ),
                                  DataCell(
                                    Text(snapshot.data![index].fatherName),
                                  ),
                                  DataCell(
                                    Text(snapshot.data![index].email),
                                  ),
                                  DataCell(
                                    Text(snapshot.data![index].password),
                                  ),
                                  DataCell(
                                    Text(snapshot.data![index].mobile),
                                  ),
                                  DataCell(
                                    Text(snapshot.data![index].landline),
                                  ),
                                  DataCell(
                                    Text(snapshot.data![index].companyName),
                                  ),
                                  DataCell(
                                    Text(snapshot.data![index].dob),
                                  ),
                                  DataCell(
                                    Text(snapshot.data![index].occupation),
                                  ),
                                  /*DataCell(
                                    Text(snapshot.data![index].jobDescription),
                                  ),
                                  DataCell(
                                    Text(snapshot.data![index].additionalResponsibilityRequired?'Yes':'No'),
                                  ),
                                  DataCell(
                                    Text(snapshot.data![index].additionalResponsibilityCode),
                                  ),
                                  DataCell(
                                    Text(snapshot.data![index].additionalResponsibility),
                                  ),
                                  DataCell(
                                    Text(snapshot.data![index].expatriates?'Yes':'No'),
                                  ),*/
                                  DataCell(
                                    Text(snapshot.data![index].location),
                                  ),
                                  DataCell(
                                    Text(snapshot.data![index].country),
                                  ),

                                  DataCell(
                                    Text(snapshot.data![index].gender),
                                  ),
                                  DataCell(
                                    Text(snapshot.data![index].mainGroup),
                                  ),
                                  DataCell(
                                      InkWell(
                                        onTap: (){
                                          _showSubGroupsDialog(snapshot.data![index]);
                                        },
                                        child: const Text("View"),
                                      )
                                  ),
                                  DataCell(
                                    Text(snapshot.data![index].refer.toString()),
                                  ),
                                  DataCell(
                                    Text(snapshot.data![index].action.toString()),
                                  ),
                                  DataCell(
                                    Text(snapshot.data![index].group.toString()),
                                  ),
                                  DataCell(
                                    Text(snapshot.data![index].subGroup1Representative.toString()),
                                  ),
                                  DataCell(
                                    Text(snapshot.data![index].subGroup2Representative.toString()),
                                  ),
                                  DataCell(
                                    Text(snapshot.data![index].subGroup3Representative.toString()),
                                  ),
                                  DataCell(
                                    Text(snapshot.data![index].subGroup4Representative.toString()),
                                  ),

                                  DataCell(
                                    Row(
                                      children: [
                                        IconButton(
                                          onPressed: (){
                                            _showEditDialog(snapshot.data![index]);
                                          },
                                          icon: const Icon(Icons.edit,color: primaryColor,),
                                        ),
                                        IconButton(
                                          onPressed: ()async{
                                            await FirebaseFirestore.instance.collection('users').doc(snapshot.data![index].id).delete().then((value) {
                                              print("deleted");
                                            }).onError((error, stackTrace){

                                              CoolAlert.show(
                                                context: context,
                                                type: CoolAlertType.error,
                                                text: error.toString(),
                                              );
                                            });
                                          },
                                          icon: const Icon(Icons.delete_forever,color: primaryColor,),
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
          /*SizedBox(
              height: MediaQuery.of(context).size.height*0.8,
              width: MediaQuery.of(context).size.width,
              child:SizedBox(
                height: MediaQuery.of(context).size.height*0.8,
                width: MediaQuery.of(context).size.width,
                child:StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('users').orderBy('createdAt',descending: true).snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return const Text('Something went wrong');
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container(
                        margin: const EdgeInsets.all(30),
                        alignment: Alignment.center,
                        child: const CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.data!.size==0){
                      return Container(
                        width: double.infinity,
                        margin: const EdgeInsets.all(20),
                        padding: const EdgeInsets.all(80),
                        alignment: Alignment.center,
                        child: const Text("No user found"),
                      );
                    }
                    print("size ${snapshot.data!.size}");
                    return  DataTable2(

                        showCheckboxColumn: false,
                        columnSpacing: defaultPadding,
                        minWidth: 3000,
                        columns: const [


                        ],
                        rows:  _buildList(context, snapshot.data!.docs)
                    );
                  },
                ),

              )

          ),*/
        ],
      )
    );
  }




}




import 'dart:html';
import 'dart:ui' as UI;
import 'package:chat_app_admin/model/sub_group_3_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:sn_progress_dialog/sn_progress_dialog.dart';
import '../../data/firebase_api.dart';
import '../../model/main_group_model.dart';
import '../../model/sub_group_1_model.dart';
import '../../model/sub_group_2_model.dart';
import '../../utils/constants.dart';
import '../../utils/responsive.dart';
class SubGroup3List extends StatefulWidget {
  const SubGroup3List({Key? key}) : super(key: key);

  @override
  _SubGroup3ListState createState() => _SubGroup3ListState();
}


class _SubGroup3ListState extends State<SubGroup3List> {

  String filter='Main Group Code';
  String query='';
  var _controller=TextEditingController();
  Future<void> _showEditDialog(SubGroup3Model editModel) async {


    var _nameController=TextEditingController();
    var _mainGroupCodeController=TextEditingController();
    var _subGroup1CodeController=TextEditingController();
    var _subGroup2CodeController=TextEditingController();

    _nameController.text=editModel.name;
    _mainGroupCodeController.text=editModel.mainGroupCode;
    _subGroup1CodeController.text=editModel.subGroup1Code;
    _subGroup2CodeController.text=editModel.subGroup2Code;


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
                                child: Text("EDIT SUBGROUP 3",textAlign: TextAlign.center,style: Theme.of(context).textTheme.headline5!.apply(color: Colors.white),),
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
                                                                if ("${model.code}".contains(pattern))
                                                                  search.add(model);
                                                              });
                                                            });

                                                            return search;
                                                          },
                                                          itemBuilder: (context, MainGroupModel suggestion) {
                                                            return ListTile(
                                                              leading: const Icon(Icons.people),
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
                                                            physics: const NeverScrollableScrollPhysics(),
                                                            children: snapshot.data!.docs.map((DocumentSnapshot document) {
                                                              Map<String, dynamic> data = document.data() as Map<String, dynamic>;

                                                              return Padding(
                                                                padding: const EdgeInsets.only(top: 15.0),
                                                                child: ListTile(
                                                                  onTap: (){
                                                                    setState(() {
                                                                      _mainGroupCodeController.text="${data['code']}";
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
                                                              leading: const Icon(Icons.people),
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
                                                      StreamBuilder<QuerySnapshot>(
                                                        stream: FirebaseFirestore.instance.collection('sub_group1').where("mainGroupCode",isEqualTo: _mainGroupCodeController.text).snapshots(),
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
                                                            physics: const NeverScrollableScrollPhysics(),
                                                            children: snapshot.data!.docs.map((DocumentSnapshot document) {
                                                              Map<String, dynamic> data = document.data() as Map<String, dynamic>;

                                                              return Padding(
                                                                padding: const EdgeInsets.only(top: 15.0),
                                                                child: ListTile(
                                                                  onTap: (){
                                                                    setState(() {
                                                                      _subGroup1CodeController.text="${data['code']}";
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
                                                              leading: const Icon(Icons.people),
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
                                                      StreamBuilder<QuerySnapshot>(
                                                        stream: FirebaseFirestore.instance.collection('sub_group2').where("subGroup1Code",isEqualTo: _subGroup1CodeController.text).snapshots(),
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
                                                            physics: const NeverScrollableScrollPhysics(),
                                                            children: snapshot.data!.docs.map((DocumentSnapshot document) {
                                                              Map<String, dynamic> data = document.data() as Map<String, dynamic>;

                                                              return Padding(
                                                                padding: const EdgeInsets.only(top: 15.0),
                                                                child: ListTile(
                                                                  onTap: (){
                                                                    setState(() {
                                                                      _subGroup2CodeController.text="${data['code']}";
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
                                  "Sub Group 3 Name",
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
                                  controller: _nameController,
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

                            const SizedBox(height: 10,),


                            InkWell(
                              onTap: ()async{
                                final ProgressDialog pr = ProgressDialog(context: context);
                                pr.show(max: 100, msg: "Please wait");
                                int count=editModel.codeCount;
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
                                bool alreadyExists=false;
                                await FirebaseFirestore.instance.collection('sub_group3')
                                    .where("code",isEqualTo:"${_subGroup2CodeController.text}-${subCode}")
                                    .get().then((QuerySnapshot querySnapshot) {
                                  querySnapshot.docs.forEach((doc) {
                                    if(doc.reference.id!=editModel.id)
                                      alreadyExists=true;
                                  });
                                });
                                if(alreadyExists){
                                  pr.close();
                                  CoolAlert.show(
                                    context: context,
                                    type: CoolAlertType.error,
                                    text: "Sub Group with this code already exists",
                                  );
                                }
                                else{
                                  await FirebaseFirestore.instance.collection('sub_group3').doc(editModel.id).update({
                                    "code":'${_subGroup2CodeController.text}-${subCode}',
                                    "name":_nameController.text,
                                    "mainGroupCode":_mainGroupCodeController.text,
                                    "subGroup1Code":_subGroup1CodeController.text,
                                    "subGroup2Code":_subGroup2CodeController.text,
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
                                child: Text("Update",style: Theme.of(context).textTheme.button!.apply(color: Colors.white),),
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
  Future<void> _showSubGroupsDialog(SubGroup3Model model) async {


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
                              child: Text("SUB GROUPS 4",textAlign: TextAlign.center,style: Theme.of(context).textTheme.headline5!.apply(color: Colors.white),),
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
                      child:  StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance.collection('sub_group4')
                            .where("subGroup3Code",isEqualTo:model.code).snapshots(),
                        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return const Text('Something went wrong');
                          }

                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          if (snapshot.data!.size==0) {
                            return const Center(
                              child: Text("No Groups"),
                            );
                          }

                          return ListView(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            children: snapshot.data!.docs.map((DocumentSnapshot document) {
                              Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                              MainGroupModel model=MainGroupModel.fromMap(data,document.reference.id);
                              return ListTile(
                                leading: const Icon(Icons.people),
                                title: Text(model.name),
                                subtitle: Text(model.code),
                              );
                            }).toList(),
                          );
                        },
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
      padding: const EdgeInsets.all(defaultPadding),
      decoration: const BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        children: [
          /*SizedBox(
              height: MediaQuery.of(context).size.height*0.8,
              width: MediaQuery.of(context).size.width,
              child:StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('sub_group3').orderBy('createdAt',descending: true).snapshots(),
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
                          label: Text("Sub Group 1 Code"),
                        ),
                        DataColumn(
                          label: Text("Sub Group 2 Code"),
                        ),
                        DataColumn(
                          label: Text("Sub Group 3 Name"),
                        ),

                        DataColumn(
                          label: Text("Sub Group 3 Code"),
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
                      items: ['Main Group Code','Sub Group 1 Code','Sub Group 2 Code','Sub Group 3'].map<DropdownMenuItem<String>>((String value) {
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
            child: FutureBuilder<List<SubGroup3Model>>(
                future: FirebaseApi.getAllSubgroup3Filtered(filter,query),
                builder: (context, AsyncSnapshot<List<SubGroup3Model>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
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
                              label: Text("Main Group Code/Name"),
                            ),
                            DataColumn(
                              label: Text("Sub group1 Code/Name"),
                            ),
                            DataColumn(
                              label: Text("Sub Group 2 Code/Name"),
                            ),
                            DataColumn(
                              label: Text("Sub Group 3 Name"),
                            ),
                            DataColumn(
                              label: Text("Sub Group 3 Code"),
                            ),
                            DataColumn(
                              label: Text("Sub Groups"),
                            ),
                            DataColumn(
                              label: Text("Actions"),
                            ),


                          ],
                          rows:  List<DataRow>.generate(snapshot.data!.length, (index){
                            return DataRow(
                                cells: [

                                  DataCell( FutureBuilder<MainGroupModel?>(
                                      future: FirebaseApi.getMainGroupModel(snapshot.data![index].mainGroupCode),
                                      builder: (context, AsyncSnapshot<MainGroupModel?> usersnap) {
                                        if (usersnap.connectionState == ConnectionState.waiting) {
                                          return const Center(
                                            child: CupertinoActivityIndicator(),
                                          );
                                        }
                                        else {
                                          if (usersnap.hasError) {
                                            print("error ${usersnap.error}");
                                            return Center(
                                              child: Text("${usersnap.error}"),
                                            );
                                          }



                                          else {
                                            if(usersnap.data==null){
                                              return Text('${snapshot.data![index].mainGroupCode}/ N/A');
                                            }
                                            else{
                                              return Text('${snapshot.data![index].mainGroupCode}/${usersnap.data!.name}');

                                            }

                                          }
                                        }
                                      }
                                  ),),
                                  DataCell( FutureBuilder<SubGroup1Model?>(
                                      future: FirebaseApi.getSubGroup1Model(snapshot.data![index].subGroup1Code),
                                      builder: (context, AsyncSnapshot<SubGroup1Model?> usersnap) {
                                        if (usersnap.connectionState == ConnectionState.waiting) {
                                          return const Center(
                                            child: CupertinoActivityIndicator(),
                                          );
                                        }
                                        else {
                                          if (usersnap.hasError) {
                                            print("error ${usersnap.error}");
                                            return Center(
                                              child: Text("${usersnap.error}"),
                                            );
                                          }



                                          else {
                                            if(usersnap.data==null){
                                              return Text('${snapshot.data![index].subGroup1Code}/ N/A');
                                            }
                                            else{
                                              return Text('${snapshot.data![index].subGroup1Code}/${usersnap.data!.name}');

                                            }

                                          }
                                        }
                                      }
                                  ),),
                                  DataCell( FutureBuilder<SubGroup2Model?>(
                                      future: FirebaseApi.getSubGroup2Model(snapshot.data![index].subGroup2Code),
                                      builder: (context, AsyncSnapshot<SubGroup2Model?> usersnap) {
                                        if (usersnap.connectionState == ConnectionState.waiting) {
                                          return const Center(
                                            child: CupertinoActivityIndicator(),
                                          );
                                        }
                                        else {
                                          if (usersnap.hasError) {
                                            print("error ${usersnap.error}");
                                            return Center(
                                              child: Text("${usersnap.error}"),
                                            );
                                          }



                                          else {
                                            if(usersnap.data==null){
                                              return Text('${snapshot.data![index].subGroup2Code}/ N/A');
                                            }
                                            else{
                                              return Text('${snapshot.data![index].subGroup2Code}/${usersnap.data!.name}');

                                            }

                                          }
                                        }
                                      }
                                  ),),
                                  DataCell(Text(snapshot.data![index].name)),
                                  DataCell(Text(snapshot.data![index].code)),
                                  DataCell(
                                      InkWell(
                                        onTap: (){
                                          _showSubGroupsDialog(snapshot.data![index]);
                                        },
                                        child: const Text("View",),
                                      )
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
                                            await FirebaseFirestore.instance.collection('sub_group2').doc(snapshot.data![index].id).delete().then((value) {
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
        ],
      )
    );
  }
  List<DataRow> _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return  snapshot.map((data) => _buildListItem(context, data)).toList();
  }

  DataRow _buildListItem(BuildContext context, DocumentSnapshot data) {
    final model = SubGroup3Model.fromSnapshot(data);
    return DataRow(
        cells: [
          DataCell(Text(model.mainGroupCode)),
          DataCell(Text(model.subGroup1Code)),
          DataCell(Text(model.subGroup2Code)),
          DataCell(Text(model.name)),
          DataCell(Text(model.code)),
          DataCell(
              InkWell(
                onTap: (){
                  _showSubGroupsDialog(model);
                },
                child: const Text("View",),
              )
          ),
          DataCell(
            Row(
              children: [
                IconButton(
                  onPressed: (){
                    _showEditDialog(model);
                  },
                  icon: const Icon(Icons.edit,color: primaryColor,),
                ),
                IconButton(
                  onPressed: ()async{
                    await FirebaseFirestore.instance.collection('sub_group3').doc(model.id).delete().then((value) {
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
  }



}




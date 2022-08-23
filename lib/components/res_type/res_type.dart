import 'dart:html';
import 'dart:ui' as UI;
import 'package:chat_app_admin/components/groups/groups_list.dart';
import 'package:chat_app_admin/components/location/location_list.dart';
import 'package:chat_app_admin/components/occupations/occupation_list.dart';
import 'package:chat_app_admin/components/res_type/res_type_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
import '../../utils/constants.dart';
import '../../utils/header.dart';
import '../../utils/responsive.dart';
class ResponsibilityType extends StatefulWidget {

  GlobalKey<ScaffoldState> _scaffoldKey;

  ResponsibilityType(this._scaffoldKey);

  @override
  _ResponsibilityTypeState createState() => _ResponsibilityTypeState();
}

class _ResponsibilityTypeState extends State<ResponsibilityType> {

  Future<void> _showAddDialog() async {
    var _nameController=TextEditingController();
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
                                child: Text("ADD RESPONSIBILITY TYPE",textAlign: TextAlign.center,style: Theme.of(context).textTheme.headline5!.apply(color: Colors.white),),
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
                                  "Responsibility Type Name",
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
                                if (_formKey.currentState!.validate()){
                                  final ProgressDialog pr = ProgressDialog(context: context);
                                  pr.show(max: 100, msg: "Please wait");
                                  int count=0;
                                  await FirebaseFirestore.instance.collection('res_type')
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
                                  await FirebaseFirestore.instance.collection('res_type').add({
                                    "name":_nameController.text,
                                    "code":subCode,
                                    "codeCount":count,
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
                                }
                              },
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7),
                                  color: primaryColor,
                                ),
                                alignment: Alignment.center,
                                child: Text("Add Responsibility Type",style: Theme.of(context).textTheme.button!.apply(color: Colors.white),),
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
            Header("Responsibility Type",widget._scaffoldKey),
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
                              _showAddDialog();
                            },
                            icon: Icon(Icons.add),
                            label: Text("Add Responsibility Type"),
                          ),
                        ],
                      ),

                      SizedBox(height: defaultPadding),
                      ResponsibilityTypeList(),
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
}


import 'dart:convert';
import 'dart:typed_data';

import 'package:chat_app_admin/components/location/location_list.dart';
import 'package:chat_app_admin/components/occupations/occupation_list.dart';
import 'package:chat_app_admin/data/firebase_api.dart';
import 'package:chat_app_admin/model/attributes_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
import '../../utils/constants.dart';
import '../../utils/header.dart';
import '../../utils/responsive.dart';
class Location extends StatefulWidget {

  GlobalKey<ScaffoldState> _scaffoldKey;

  Location(this._scaffoldKey);

  @override
  _LocationState createState() => _LocationState();
}

class _LocationState extends State<Location> {

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
                                child: Text("ADD LOCATION",textAlign: TextAlign.center,style: Theme.of(context).textTheme.headline5!.apply(color: Colors.white),),
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
                                  "Location Name",
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
                                  await FirebaseFirestore.instance.collection('location')
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
                                  await FirebaseFirestore.instance.collection('location').add({
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
                                child: Text("Add Location",style: Theme.of(context).textTheme.button!.apply(color: Colors.white),),
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
            Header("Location",widget._scaffoldKey),
            SizedBox(height: defaultPadding),
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
                            icon: Icon(Icons.add),
                            label: Text("Add Location"),
                          ),
                          SizedBox(width: 10,),
                          ElevatedButton.icon(
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
                                List<AttributeModel> locations=[];
                                parsedCSV.forEach((element) {
                                  AttributeModel location=AttributeModel(
                                    '',
                                    element[1].toString(),
                                    '',
                                    0

                                  );
                                  //if(coaches.length<10)
                                  locations.add(location);

                                });
                                for (var element in locations) {
                                  if (element.name!='Name') {
                                    int count=0;
                                    await FirebaseFirestore.instance.collection('location')
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
                                    await FirebaseFirestore.instance.collection('location').add({
                                      "name":element.name,
                                      "code":subCode,
                                      "codeCount":count,
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
                          SizedBox(width: 10,),
                          ElevatedButton.icon(
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                horizontal: defaultPadding * 1.5,
                                vertical:
                                defaultPadding / (Responsive.isMobile(context) ? 2 : 1),
                              ),
                            ),
                            onPressed: ()async {
                              List<String> rowHeader = ["Code","Name"];
                              List<List<dynamic>> rows = [];
                              List<AttributeModel> list=await FirebaseApi.getAllLocations();
                              rows.add(rowHeader);
                              for(int i=0;i<list.length;i++){
                                List<dynamic> dataRow=[];
                                dataRow.add(list[i].code);
                                dataRow.add(list[i].name);
                                rows.add(dataRow);
                              }
                              String csv = const ListToCsvConverter().convert(rows);
                              Uint8List bytes = Uint8List.fromList(utf8.encode(csv));

                              await FileSaver.instance.saveFile(
                                name: 'locations',
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

                      SizedBox(height: defaultPadding),
                      LocationList(),
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

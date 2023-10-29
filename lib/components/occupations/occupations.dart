import 'dart:convert';
import 'dart:html';
import 'dart:typed_data';
import 'dart:ui' as UI;
import 'package:chat_app_admin/components/groups/groups_list.dart';
import 'package:chat_app_admin/components/occupations/occupation_list.dart';
import 'package:chat_app_admin/model/occupation_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
import '../../data/firebase_api.dart';
import '../../utils/constants.dart';
import '../../utils/header.dart';
import '../../utils/responsive.dart';
class Occupations extends StatefulWidget {

  GlobalKey<ScaffoldState> _scaffoldKey;

  Occupations(this._scaffoldKey);

  @override
  _OccupationsState createState() => _OccupationsState();
}

class _OccupationsState extends State<Occupations> {

  Future<void> _showAddDialog() async {
    var _nameController=TextEditingController();
    var _typeController=TextEditingController();
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
                                child: Text("ADD OCCUPATIONS",textAlign: TextAlign.center,style: Theme.of(context).textTheme.headline5!.apply(color: Colors.white),),
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
                                  "Occupation Name",
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

                            SizedBox(height: 20,),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Occupation Type",
                                  style: Theme.of(context).textTheme.bodyText1!.apply(color: Colors.black),
                                ),
                                TextFormField(
                                  controller: _typeController,
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
                                  "name":_nameController.text,
                                  "type":_typeController.text,
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
                                child: Text("Add Occupation",style: Theme.of(context).textTheme.button!.apply(color: Colors.white),),
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
            Header("Occupations",widget._scaffoldKey),
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
                            label: Text("Add Occupations"),
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
                              List<String> rowHeader = ["Code","Name",'Type'];
                              List<List<dynamic>> rows = [];
                              List<OccupationModel> list=await FirebaseApi.getAllOccupations();
                              rows.add(rowHeader);
                              for(int i=0;i<list.length;i++){
                                List<dynamic> dataRow=[];
                                dataRow.add(list[i].code);
                                dataRow.add(list[i].name);
                                dataRow.add(list[i].type);
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

                      SizedBox(height: defaultPadding),
                      OccupationList(),
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

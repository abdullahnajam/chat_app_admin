import 'dart:convert';
import 'dart:typed_data';

import 'package:chat_app_admin/components/sub_groups/sub_groups2_list.dart';
import 'package:chat_app_admin/components/sub_groups/sub_groups3_list.dart';
import 'package:chat_app_admin/components/sub_groups/sub_groups4_list.dart';
import 'package:chat_app_admin/components/sub_groups/sub_groups_list.dart';
import 'package:chat_app_admin/model/sub_group_1_model.dart';
import 'package:chat_app_admin/widgets/sub_group_dialogs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
import '../../data/firebase_api.dart';
import '../../model/main_group_model.dart';
import '../../model/sub_group_2_model.dart';
import '../../model/sub_group_3_model.dart';
import '../../model/sub_group_4_model.dart';
import '../../utils/constants.dart';
import '../../utils/header.dart';
import '../../utils/responsive.dart';
class SubGroups extends StatefulWidget {

  final GlobalKey<ScaffoldState> _scaffoldKey;

  int index;
  SubGroups(this._scaffoldKey,this.index, {super.key});

  @override
  _SubGroupsState createState() => _SubGroupsState();
}

class _SubGroupsState extends State<SubGroups> {




  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Header("Sub Group ${widget.index}",widget._scaffoldKey),
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
                              if(widget.index==1){
                                SubGroupDialogs.showAdd1Dialog(context);
                              }
                              else if(widget.index==2){
                                SubGroupDialogs.showAdd2Dialog(context,widget.index);
                              }
                              else if(widget.index==3){
                                SubGroupDialogs.showAdd3Dialog(context,widget.index);
                              }
                              else if(widget.index==4){
                                SubGroupDialogs.showAdd4Dialog(context,widget.index);
                              }
                            },
                            icon: const Icon(Icons.add),
                            label: Text("Add Sub Group ${widget.index}"),
                          ),
                          const SizedBox(width: 10,),
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
                                List<List<dynamic>> parsedCSV = const CsvToListConverter().convert(csvString);
                                if(widget.index==1){
                                  List<SubGroup1Model> list=[];
                                  parsedCSV.forEach((element) {
                                    SubGroup1Model model=SubGroup1Model(
                                        '',
                                        element[1].toString(),
                                        element[0].toString(),
                                        element[2].toString(),

                                    );
                                    //if(coaches.length<10)
                                    list.add(model);

                                  });
                                  for (var element in list) {
                                    if (element.name!='Name') {
                                      await FirebaseFirestore.instance.collection('sub_group1').add({
                                        "code":element.code,
                                        "name":element.name,
                                        "mainGroupCode":element.mainGroupCode,
                                        "status":"Active",
                                        "createdAt":DateTime.now().millisecondsSinceEpoch,
                                      });
                                    }


                                  }
                                }
                                if(widget.index==2){
                                  List<SubGroup2Model> list=[];
                                  parsedCSV.forEach((element) {
                                    SubGroup2Model model=SubGroup2Model(
                                      '',
                                      element[1].toString(),
                                      element[0].toString(),
                                      element[2].toString(),
                                      element[3].toString(),
                                      0

                                    );
                                    //if(coaches.length<10)
                                    list.add(model);

                                  });
                                  for (var element in list) {
                                    if (element.name!='Name') {
                                      int count=0;
                                      await FirebaseFirestore.instance.collection('sub_group2')
                                          .where("subGroup1Code",isEqualTo:element.subGroup1Code)
                                          .where("mainGroupCode",isEqualTo:element.mainGroupCode)
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
                                        "code":"${element.subGroup1Code}-$subCode",
                                        "name":element.name,
                                        "mainGroupCode":element.mainGroupCode,
                                        "subGroup1Code":element.subGroup1Code,
                                        "status":"Active",
                                        "codeCount":count,
                                        "createdAt":DateTime.now().millisecondsSinceEpoch,
                                      });
                                    }


                                  }
                                }
                                if(widget.index==3){
                                  List<SubGroup3Model> list=[];
                                  parsedCSV.forEach((element) {
                                    SubGroup3Model model=SubGroup3Model(
                                        '',
                                        element[1].toString(),
                                        element[0].toString(),
                                        element[2].toString(),
                                        element[3].toString(),
                                        element[4].toString(),
                                        0

                                    );
                                    //if(coaches.length<10)
                                    list.add(model);

                                  });
                                  for (var element in list) {
                                    if (element.name!='Name') {
                                      int count=0;
                                      await FirebaseFirestore.instance.collection('sub_group3')
                                          .where("subGroup2Code",isEqualTo:element.subGroup2Code)
                                          .where("subGroup1Code",isEqualTo:element.subGroup1Code)
                                          .where("mainGroupCode",isEqualTo:element.mainGroupCode)
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
                                        "code":'${element.subGroup2Code}-$subCode',
                                        "name":element.name,
                                        "mainGroupCode":element.mainGroupCode,
                                        "subGroup1Code":element.subGroup1Code,
                                        "subGroup2Code":element.subGroup2Code,
                                        "status":"Active",
                                        "codeCount":count,
                                        "createdAt":DateTime.now().millisecondsSinceEpoch,
                                      });
                                    }


                                  }
                                }

                                if(widget.index==4){
                                  List<SubGroup4Model> list=[];
                                  parsedCSV.forEach((element) {
                                    SubGroup4Model model=SubGroup4Model(
                                        '',
                                        element[1].toString(),
                                        element[0].toString(),
                                        element[2].toString(),
                                        element[3].toString(),
                                        element[4].toString(),
                                        element[5].toString(),
                                        0

                                    );
                                    //if(coaches.length<10)
                                    list.add(model);

                                  });
                                  for (var element in list) {
                                    if (element.name!='Name') {
                                      int count=0;
                                      await FirebaseFirestore.instance.collection('sub_group4')
                                          .where("subGroup3Code",isEqualTo:element.subGroup3Code)
                                          .where("subGroup2Code",isEqualTo:element.subGroup2Code)
                                          .where("subGroup1Code",isEqualTo:element.subGroup1Code)
                                          .where("mainGroupCode",isEqualTo:element.mainGroupCode)
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
                                        "code":'${element.subGroup3Code}-$subCode',
                                        "name":element.name,
                                        "mainGroupCode":element.mainGroupCode,
                                        "subGroup1Code":element.subGroup1Code,
                                        "subGroup2Code":element.subGroup2Code,
                                        "subGroup3Code":element.subGroup3Code,
                                        "status":"Active",
                                        "codeCount":count,

                                        "createdAt":DateTime.now().millisecondsSinceEpoch,
                                      });
                                    }


                                  }
                                }


                              }

                            },
                            icon: const Icon(Icons.upload),
                            label: const Text("Import"),
                          ),
                          const SizedBox(width: 10,),
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
                                List<String> rowHeader = ["Code","Name",'Main Group Code'];
                                List<List<dynamic>> rows = [];
                                List<SubGroup1Model> list=await FirebaseApi.getAllSubgroup1();
                                rows.add(rowHeader);
                                for(int i=0;i<list.length;i++){
                                  List<dynamic> dataRow=[];
                                  dataRow.add(list[i].code);
                                  dataRow.add(list[i].name);
                                  dataRow.add(list[i].mainGroupCode);
                                  rows.add(dataRow);
                                }
                                String csv = const ListToCsvConverter().convert(rows);
                                Uint8List bytes = Uint8List.fromList(utf8.encode(csv));

                                await FileSaver.instance.saveFile(
                                  name: 'subgroup1',
                                  bytes: bytes,
                                  ext: 'csv',
                                  mimeType: MimeType.csv,
                                );
                              }
                              if(widget.index==2){
                                List<String> rowHeader = ["Code","Name",'Main Group Code','Sub Group1 Code'];
                                List<List<dynamic>> rows = [];
                                List<SubGroup2Model> list=await FirebaseApi.getAllSubgroup2();
                                rows.add(rowHeader);
                                for(int i=0;i<list.length;i++){
                                  List<dynamic> dataRow=[];
                                  dataRow.add(list[i].code);
                                  dataRow.add(list[i].name);
                                  dataRow.add(list[i].mainGroupCode);
                                  dataRow.add(list[i].subGroup1Code);
                                  rows.add(dataRow);
                                }
                                String csv = const ListToCsvConverter().convert(rows);
                                Uint8List bytes = Uint8List.fromList(utf8.encode(csv));

                                await FileSaver.instance.saveFile(
                                  name: 'subgroup2',
                                  bytes: bytes,
                                  ext: 'csv',
                                  mimeType: MimeType.csv,
                                );
                              }
                              if(widget.index==3){
                                List<String> rowHeader = ["Code","Name",'Main Group Code','Sub Group1 Code','Sub Group2 Code'];
                                List<List<dynamic>> rows = [];
                                List<SubGroup3Model> list=await FirebaseApi.getAllSubgroup3();
                                rows.add(rowHeader);
                                for(int i=0;i<list.length;i++){
                                  List<dynamic> dataRow=[];
                                  dataRow.add(list[i].code);
                                  dataRow.add(list[i].name);
                                  dataRow.add(list[i].mainGroupCode);
                                  dataRow.add(list[i].subGroup1Code);
                                  dataRow.add(list[i].subGroup2Code);
                                  rows.add(dataRow);
                                }
                                String csv = const ListToCsvConverter().convert(rows);
                                Uint8List bytes = Uint8List.fromList(utf8.encode(csv));

                                await FileSaver.instance.saveFile(
                                  name: 'subgroup3',
                                  bytes: bytes,
                                  ext: 'csv',
                                  mimeType: MimeType.csv,
                                );
                              }
                              if(widget.index==4){
                                List<String> rowHeader = ["Code","Name",'Main Group Code','Sub Group1 Code','Sub Group2 Code','Sub Group3 Code'];
                                List<List<dynamic>> rows = [];
                                List<SubGroup4Model> list=await FirebaseApi.getAllSubgroup4();
                                rows.add(rowHeader);
                                for(int i=0;i<list.length;i++){
                                  List<dynamic> dataRow=[];
                                  dataRow.add(list[i].code);
                                  dataRow.add(list[i].name);
                                  dataRow.add(list[i].mainGroupCode);
                                  dataRow.add(list[i].subGroup1Code);
                                  dataRow.add(list[i].subGroup2Code);
                                  dataRow.add(list[i].subGroup3Code);
                                  rows.add(dataRow);
                                }
                                String csv = const ListToCsvConverter().convert(rows);
                                Uint8List bytes = Uint8List.fromList(utf8.encode(csv));

                                await FileSaver.instance.saveFile(
                                  name: 'subgroup4',
                                  bytes: bytes,
                                  ext: 'csv',
                                  mimeType: MimeType.csv,
                                );
                              }


                            },
                            icon: const Icon(Icons.download),
                            label: const Text("Export"),
                          ),
                        ],
                      ),

                      const SizedBox(height: defaultPadding),
                      if(widget.index==1)
                        const SubGroupList()
                      else if(widget.index==2)
                        const SubGroup2List()
                      else if(widget.index==3)
                          const SubGroup3List()
                        else if(widget.index==4)
                            const SubGroup4List(),
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

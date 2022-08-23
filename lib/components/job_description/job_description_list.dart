import 'dart:html';
import 'dart:ui' as UI;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
import '../../model/attributes_model.dart';
import '../../utils/constants.dart';
import '../../utils/responsive.dart';
class JobDescriptionList extends StatefulWidget {
  const JobDescriptionList({Key? key}) : super(key: key);

  @override
  _JobDescriptionListState createState() => _JobDescriptionListState();
}


class _JobDescriptionListState extends State<JobDescriptionList> {


  Future<void> _showEditDialog(AttributeModel model) async {
    var _nameController=TextEditingController();
    _nameController.text=model.name;
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
                                child: Text("EDIT JOB DESCRIPTION",textAlign: TextAlign.center,style: Theme.of(context).textTheme.headline5!.apply(color: Colors.white),),
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
                                  "Job Description Name",
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
                                  await FirebaseFirestore.instance.collection('job_description').doc(model.id).update({
                                    "name":_nameController.text,
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
                                child: Text("Update Job Description",style: Theme.of(context).textTheme.button!.apply(color: Colors.white),),
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
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child:  SizedBox(
        height: MediaQuery.of(context).size.height*0.8,
        width: MediaQuery.of(context).size.width,
        child:StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('job_description').orderBy('createdAt',descending: true).snapshots(),
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
                child: Text("No data found"),
              );
            }
            print("size ${snapshot.data!.size}");
            return  DataTable2(

                showCheckboxColumn: false,
                columnSpacing: defaultPadding,
                minWidth: 600,
                columns: const [

                  DataColumn(
                    label: Text("Code"),
                  ),

                  DataColumn(
                    label: Text("Name"),
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
    final model = AttributeModel.fromSnapshot(data);
    return DataRow(
        cells: [
          DataCell(Text(model.code)),
          DataCell(Text(model.name)),

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
                    await FirebaseFirestore.instance.collection('job_description').doc(model.id).delete().then((value) {
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




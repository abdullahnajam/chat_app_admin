import 'package:chat_app_admin/model/user_model.dart';
import 'package:chat_app_admin/utils/responsive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

class CustomDialogs {
  static Future<void> showUserDataDialog(BuildContext context, UserModel user) async {

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
                height: MediaQuery.of(context).size.height,
                width: Responsive.isMobile(context)?MediaQuery.of(context).size.width*0.9:MediaQuery.of(context).size.width*0.7,
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
                              child: Text("USER DETAILS",textAlign: TextAlign.center,style: Theme.of(context).textTheme.headline5!.apply(color: Colors.white),),
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
                          /*Container(
                            height: 120,
                            width: 120,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: NetworkImage(user.profilePicture),
                                    fit: BoxFit.cover
                                )
                            ),
                          ),*/
                          ListTile(
                            title: Text("Basic Information",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                          ),
                          ListTile(
                            title: Text("User ID"),
                            trailing: Text(user.id),
                          ),
                          ListTile(
                            title: Text("Email"),
                            trailing: Text(user.email),
                          ),
                          ListTile(
                            title: Text("Name"),
                            trailing: Text(user.name),

                          ),
                          ListTile(
                            title: Text("Display Name"),
                            trailing: Text(user.displayName),

                          ),
                          ListTile(
                            title: Text("Father Name"),
                            trailing: Text(user.fatherName),

                          ),
                          ListTile(
                            title: Text("Mobile Number"),
                            trailing: Text(user.mobile),

                          ),

                          ListTile(
                            title: Text("Landline Number"),
                            trailing: Text(user.landline),

                          ),
                          ListTile(
                            title: Text("Gender"),
                            trailing: Text(user.gender),

                          ),
                          ListTile(
                            title: Text("Date Of Birth"),
                            trailing: Text(user.dob),

                          ),

                          ListTile(
                            title: Text("City"),
                            trailing: Text(user.location),

                          ),

                          ListTile(
                            title: Text("Country"),
                            trailing: Text(user.country),

                          ),

                          ListTile(
                            title: Text("Occupation"),
                            trailing: Text(user.occupation),

                          ),

                          ListTile(
                            title: Text("Job Description"),
                            trailing: Text(user.jobDescription),

                          ),

                          ListTile(
                            title: Text("Group Information",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                          ),
                          ListTile(
                            title: Text("Main Group"),
                            trailing: Text(user.mainGroup),

                          ),
                          ListTile(
                            title: Text("Sub Group 1"),
                            trailing: Text(user.subGroup1),

                          ),
                          ListTile(
                            title: Text("Sub Group 2"),
                            trailing: Text(user.subGroup2),

                          ),
                          ListTile(
                            title: Text("Sub Group 3"),
                            trailing: Text(user.subGroup3),

                          ),
                          ListTile(
                            title: Text("Sub Group 4"),
                            trailing: Text(user.subGroup4),

                          ),

                          ListTile(
                            title: Text("Additional Information",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                          ),
                          ListTile(
                            title: Text("Sub Group 1 Representative"),
                            trailing: Text(user.subGroup1Representative?'Yes':'No'),

                          ),
                          ListTile(
                            title: Text("Sub Group 2 Representative"),
                            trailing: Text(user.subGroup2Representative?'Yes':'No'),

                          ),
                          ListTile(
                            title: Text("Sub Group 3 Representative"),
                            trailing: Text(user.subGroup3Representative?'Yes':'No'),

                          ),
                          ListTile(
                            title: Text("Sub Group 4 Representative"),
                            trailing: Text(user.subGroup4Representative?'Yes':'No'),

                          ),
                          ListTile(
                            title: Text("Expatriates"),
                            trailing: Text(user.expatriates?'Yes':'No'),

                          ),
                          ListTile(
                            title: Text("Action"),
                            trailing: Text(user.action?'Yes':'No'),

                          ),
                          ListTile(
                            title: Text("Action"),
                            trailing: Text(user.action?'Yes':'No'),

                          ),
                          ListTile(
                            title: Text("Refer To Friend"),
                            trailing: Text(user.refer?'Yes':'No'),

                          ),
                        ],
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
}

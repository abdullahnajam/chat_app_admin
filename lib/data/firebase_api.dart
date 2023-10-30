import 'package:chat_app_admin/model/attributes_model.dart';
import 'package:chat_app_admin/model/main_group_model.dart';
import 'package:chat_app_admin/model/occupation_model.dart';
import 'package:chat_app_admin/model/sub_group_1_model.dart';
import 'package:chat_app_admin/model/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/sub_group_2_model.dart';
import '../model/sub_group_3_model.dart';
import '../model/sub_group_4_model.dart';

class FirebaseApi{
  static Future<List<AttributeModel>> getAllLocations()async{
    List<AttributeModel> list=[];
    await FirebaseFirestore.instance.collection('location').get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) async{
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        AttributeModel model=AttributeModel.fromMap(data, doc.reference.id);
        list.add(model);

      });
    });
    return list;

  }

  static Future<List<OccupationModel>> getAllOccupations()async{
    List<OccupationModel> list=[];
    await FirebaseFirestore.instance.collection('occupation').get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) async{
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        OccupationModel model=OccupationModel.fromMap(data, doc.reference.id);
        list.add(model);

      });
    });
    return list;

  }
  static Future<List<UserModel>> getAllUsers()async{
    List<UserModel> list=[];
    await FirebaseFirestore.instance.collection('users').get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) async{
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        UserModel model=UserModel.fromMap(data, doc.reference.id);
        list.add(model);

      });
    });
    return list;

  }
  static Future<List<SubGroup4Model>> getAllSubgroup4()async{
    List<SubGroup4Model> list=[];
    await FirebaseFirestore.instance.collection('sub_group4').get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) async{
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        SubGroup4Model model=SubGroup4Model.fromMap(data, doc.reference.id);
        list.add(model);

      });
    });
    return list;

  }
  static Future<List<SubGroup1Model>> getAllSubgroup1Filtered(String filter,String query)async{
    List<SubGroup1Model> list=[];

    await FirebaseFirestore.instance.collection('sub_group1').get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) async{
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        SubGroup1Model model=SubGroup1Model.fromMap(data, doc.reference.id);
        if(query!=''){
          if(filter=='Main Group Code'){
            if(model.mainGroupCode.toLowerCase().contains(query.toLowerCase().trim())){
              list.add(model);
            }
          }
          else if(filter=='Sub Group 1'){
            if(model.name.toLowerCase().contains(query.toLowerCase().trim())){
              list.add(model);
            }
          }
        }


      });
    });
    return list;

  }

  static Future<List<SubGroup2Model>> getAllSubgroup2Filtered(String filter,String query)async{
    List<SubGroup2Model> list=[];

    await FirebaseFirestore.instance.collection('sub_group2').get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) async{
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        SubGroup2Model model=SubGroup2Model.fromMap(data, doc.reference.id);
        if(query!=''){
          if(filter=='Main Group Code'){
            if(model.mainGroupCode.toLowerCase().contains(query.toLowerCase().trim())){
              list.add(model);
            }
          }
          else if(filter=='Sub Group 1 Code'){
            if(model.subGroup1Code.toLowerCase().contains(query.toLowerCase().trim())){
              list.add(model);
            }
          }
          else if(filter=='Sub Group 2'){
            if(model.name.toLowerCase().contains(query.toLowerCase().trim())){
              list.add(model);
            }
          }
        }


      });
    });
    return list;

  }

  static Future<List<SubGroup3Model>> getAllSubgroup3Filtered(String filter,String query)async{
    List<SubGroup3Model> list=[];

    await FirebaseFirestore.instance.collection('sub_group3').get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) async{
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        SubGroup3Model model=SubGroup3Model.fromMap(data, doc.reference.id);
        if(query!=''){
          if(filter=='Main Group Code'){
            if(model.mainGroupCode.toLowerCase().contains(query.toLowerCase().trim())){
              list.add(model);
            }
          }
          else if(filter=='Sub Group 1 Code'){
            if(model.subGroup1Code.toLowerCase().contains(query.toLowerCase().trim())){
              list.add(model);
            }
          }
          else if(filter=='Sub Group 2 Code'){
            if(model.subGroup2Code.toLowerCase().contains(query.toLowerCase().trim())){
              list.add(model);
            }
          }
          else if(filter=='Sub Group 3'){
            if(model.name.toLowerCase().contains(query.toLowerCase().trim())){
              list.add(model);
            }
          }
        }


      });
    });
    return list;

  }

  static Future<List<SubGroup4Model>> getAllSubgroup4Filtered(String filter,String query)async{
    List<SubGroup4Model> list=[];

    await FirebaseFirestore.instance.collection('sub_group4').get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) async{
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        SubGroup4Model model=SubGroup4Model.fromMap(data, doc.reference.id);
        if(query!=''){
          if(filter=='Main Group Code'){
            if(model.mainGroupCode.toLowerCase().contains(query.toLowerCase().trim())){
              list.add(model);
            }
          }
          else if(filter=='Sub Group 1 Code'){
            if(model.subGroup1Code.toLowerCase().contains(query.toLowerCase().trim())){
              list.add(model);
            }
          }
          else if(filter=='Sub Group 2 Code'){
            if(model.subGroup2Code.toLowerCase().contains(query.toLowerCase().trim())){
              list.add(model);
            }
          }
          else if(filter=='Sub Group 3 Code'){
            if(model.subGroup3Code.toLowerCase().contains(query.toLowerCase().trim())){
              list.add(model);
            }
          }
          else if(filter=='Sub Group 4'){
            if(model.name.toLowerCase().contains(query.toLowerCase().trim())){
              list.add(model);
            }
          }
        }


      });
    });
    return list;

  }

  static Future<List<UserModel>> getAllUsersFiltered(String filter,String query)async{
    List<UserModel> list=[];
    //                      items: ['','Email','','','']
    await FirebaseFirestore.instance.collection('users').get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) async{
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        UserModel model=UserModel.fromMap(data, doc.reference.id);
        if(query!=''){
          if(filter=='Name'){
            if(model.name.toLowerCase().contains(query.toLowerCase().trim())){
              list.add(model);
            }
          }
          else if(filter=='Email'){
            if(model.email.toLowerCase().contains(query.toLowerCase().trim())){
              list.add(model);
            }
          }
          else if(filter=='Mobile'){
            if(model.mobile.toLowerCase().contains(query.toLowerCase().trim())){
              list.add(model);
            }
          }
          else if(filter=='City'){
            if(model.location.toLowerCase().contains(query.toLowerCase().trim())){
              list.add(model);
            }
          }
          else if(filter=='Country'){
            if(model.country.toLowerCase().contains(query.toLowerCase().trim())){
              list.add(model);
            }
          }
          else if(filter=='Main Group'){
            if(model.mainGroup.toLowerCase().contains(query.toLowerCase().trim())){
              list.add(model);
            }
          }
          else if(filter=='Sub Group 1'){
            if(model.subGroup1.toLowerCase().contains(query.toLowerCase().trim())){
              list.add(model);
            }
          }
          else if(filter=='Sub Group 2'){
            if(model.subGroup2.toLowerCase().contains(query.toLowerCase().trim())){
              list.add(model);
            }
          }
          else if(filter=='Sub Group 3'){
            if(model.subGroup3.toLowerCase().contains(query.toLowerCase().trim())){
              list.add(model);
            }
          }
          else if(filter=='Sub Group 4'){
            if(model.subGroup4.toLowerCase().contains(query.toLowerCase().trim())){
              list.add(model);
            }
          }
        }


      });
    });
    return list;

  }


  static Future<List<SubGroup1Model>> getAllSubgroup1()async{
    List<SubGroup1Model> list=[];

    await FirebaseFirestore.instance.collection('sub_group1').get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) async{
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        SubGroup1Model model=SubGroup1Model.fromMap(data, doc.reference.id);
        list.add(model);


      });
    });
    return list;

  }
  static Future<List<SubGroup2Model>> getAllSubgroup2()async{
    List<SubGroup2Model> list=[];
    await FirebaseFirestore.instance.collection('sub_group2').get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) async{
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        SubGroup2Model model=SubGroup2Model.fromMap(data, doc.reference.id);
        list.add(model);

      });
    });
    return list;

  }
  static Future<List<SubGroup3Model>> getAllSubgroup3()async{
    List<SubGroup3Model> list=[];
    await FirebaseFirestore.instance.collection('sub_group3').get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) async{
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        SubGroup3Model model=SubGroup3Model.fromMap(data, doc.reference.id);
        list.add(model);

      });
    });
    return list;

  }

  static Future<MainGroupModel?> getMainGroupModel(String code)async{
    print('main code $code');
    MainGroupModel? model;
    await FirebaseFirestore.instance.collection('main_group').where('code',isEqualTo: code).get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) async{
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        MainGroupModel m=MainGroupModel.fromMap(data, doc.reference.id);
        model=m;

      });
    });
    return model;

  }
  static Future<SubGroup1Model?> getSubGroup1Model(String code)async{
    SubGroup1Model? model;
    await FirebaseFirestore.instance.collection('sub_group1').where('code',isEqualTo: code).get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) async{
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        SubGroup1Model m=SubGroup1Model.fromMap(data, doc.reference.id);
        model=m;

      });
    });
    return model;

  }
  static Future<SubGroup2Model?> getSubGroup2Model(String code)async{
    SubGroup2Model? model;
    await FirebaseFirestore.instance.collection('sub_group2').where('code',isEqualTo: code).get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) async{
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        SubGroup2Model m=SubGroup2Model.fromMap(data, doc.reference.id);
        model=m;

      });
    });
    return model;

  }
  static Future<SubGroup3Model?> getSubGroup3Model(String code)async{
    SubGroup3Model? model;
    await FirebaseFirestore.instance.collection('sub_group3').where('code',isEqualTo: code).get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) async{
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        SubGroup3Model m=SubGroup3Model.fromMap(data, doc.reference.id);
        model=m;

      });
    });
    return model;

  }

}
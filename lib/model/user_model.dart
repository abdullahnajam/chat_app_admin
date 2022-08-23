import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel{
  String id,name,email,mobile,gender,displayName,mainGroup,mainGroupCode,subGroup1,subGroup1Code,subGroup2Code,subGroup2,
      subGroup3Code,subGroup3,subGroup4Code,subGroup4,password,fatherName,dob,landline,companyName,
      occupation,jobDescription,res_type,country,additionalResponsibility,location,additionalResponsibilityCode;
  bool refer,subGroup1Representative,subGroup2Representative,subGroup3Representative
  ,group,subGroup4Representative,action;






  UserModel.fromMap(Map<String,dynamic> map,String key)
      : id=key,
        name = map['name'],
        subGroup1Representative = map['subGroup1Representative'],
        subGroup2Representative = map['subGroup2Representative'],
        subGroup3Representative = map['subGroup3Representative'],
        subGroup4Representative = map['subGroup4Representative'],
        group = map['group'],
        action = map['action'],
        country = map['country']??"",
        companyName = map['companyName']??"",
        password = map['password'],
        fatherName = map['fatherName'],
        dob = map['dob'],
        landline = map['landline'],
        occupation = map['occupation'],
        jobDescription = map['jobDescription'],
        res_type = map['res_type'],
        additionalResponsibility = map['additionalResponsibility'],
        location = map['location'],
        additionalResponsibilityCode = map['additionalResponsibilityCode'],
        mobile = map['mobile'],
        gender = map['gender']??"Male",
        displayName = map['displayName'],
        refer = map['refer'],
        mainGroup = map['mainGroup'],
        subGroup1 = map['subGroup1'],
        subGroup2 = map['subGroup2'],
        subGroup3 = map['subGroup3'],
        subGroup4 = map['subGroup4'],
        mainGroupCode = map['mainGroupCode'],
        subGroup1Code = map['subGroup1Code'],
        subGroup2Code = map['subGroup2Code'],
        subGroup3Code = map['subGroup3Code'],
        subGroup4Code = map['subGroup4Code'],
        email = map['email'];



  UserModel.fromSnapshot(DocumentSnapshot snapshot )
      : this.fromMap(snapshot.data() as Map<String, dynamic>,snapshot.reference.id);
}
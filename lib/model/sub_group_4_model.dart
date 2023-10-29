import 'package:cloud_firestore/cloud_firestore.dart';

class SubGroup4Model{
  String id,name,code,mainGroupCode,subGroup1Code,subGroup2Code,subGroup3Code;
  int codeCount;

  SubGroup4Model.fromMap(Map<String,dynamic> map,String key)
      : id=key,
        name = map['name'],
        mainGroupCode = map['mainGroupCode'],
        subGroup1Code = map['subGroup1Code'],
        subGroup2Code = map['subGroup2Code'],
        subGroup3Code = map['subGroup3Code'],
        codeCount = map['codeCount']??1,
        code = map['code'];


  SubGroup4Model(
      this.id,
      this.name,
      this.code,
      this.mainGroupCode,
      this.subGroup1Code,
      this.subGroup2Code,
      this.subGroup3Code,
      this.codeCount);

  SubGroup4Model.fromSnapshot(DocumentSnapshot snapshot )
      : this.fromMap(snapshot.data() as Map<String, dynamic>,snapshot.reference.id);
}
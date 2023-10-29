import 'package:cloud_firestore/cloud_firestore.dart';

class SubGroup2Model{
  String id,name,code,mainGroupCode,subGroup1Code;
  int codeCount;


  SubGroup2Model.fromMap(Map<String,dynamic> map,String key)
      : id=key,
        name = map['name'],
        mainGroupCode = map['mainGroupCode'],
        subGroup1Code = map['subGroup1Code'],
        codeCount = map['codeCount']??1,
        code = map['code'];


  SubGroup2Model(this.id, this.name, this.code, this.mainGroupCode,
      this.subGroup1Code, this.codeCount);

  SubGroup2Model.fromSnapshot(DocumentSnapshot snapshot )
      : this.fromMap(snapshot.data() as Map<String, dynamic>,snapshot.reference.id);
}
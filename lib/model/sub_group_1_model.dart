import 'package:cloud_firestore/cloud_firestore.dart';

class SubGroup1Model{
  String id,name,code,mainGroupCode;


  SubGroup1Model.fromMap(Map<String,dynamic> map,String key)
      : id=key,
        name = map['name'],
        mainGroupCode = map['mainGroupCode'],
        code = map['code'];


  SubGroup1Model(this.id, this.name, this.code, this.mainGroupCode);

  SubGroup1Model.fromSnapshot(DocumentSnapshot snapshot )
      : this.fromMap(snapshot.data() as Map<String, dynamic>,snapshot.reference.id);
}
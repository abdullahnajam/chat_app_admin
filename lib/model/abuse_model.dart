import 'package:cloud_firestore/cloud_firestore.dart';




class AbuseModel{
  String id,abuser_id,reporter_id,topic,report,status;
  int createdAt;

  AbuseModel.fromMap(Map<String,dynamic> map,String key)
      : id=key,
        abuser_id = map['abuser_id']??'',
        reporter_id = map['reporter_id']??'',
        topic = map['topic']??'',
        report = map['report']??'',
        status = map['status']??'Pending',
        createdAt = map['createdAt']??DateTime.now().millisecondsSinceEpoch;



  AbuseModel.fromSnapshot(DocumentSnapshot snapshot )
      : this.fromMap(snapshot.data() as Map<String, dynamic>,snapshot.reference.id);
}
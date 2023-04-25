class messagemodel{
  String? senderid;
  String? reciverid;
  String? datetime;
  String? text;

  messagemodel({this.text, this.datetime, this.reciverid, this.senderid});
  messagemodel.fromjson(Map<String,dynamic>json){
    senderid=json['senderid'];
    reciverid=json['reciverid'];
    datetime=json['datetime'];
    text=json['text'];

  }
  Map<String,dynamic>tomap(){
    return {
      'senderid':senderid,
      'reciverid':reciverid,
      'datetime':datetime,
      'text':text,
    };
  }

}
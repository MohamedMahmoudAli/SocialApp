class postmodel{
  String? name;
  String? uId;
  String?image;
  String? datetime;
  String? text;
  String? postimage;


  postmodel({this.name, this.uId,this.text,this.image,this.postimage,this.datetime});
  postmodel.fromjson(Map<String,dynamic>json){
    name=json['name'];
    uId=json['uId'];
    image=json['image'];
    datetime=json['datetime'];
    text=json['text'];
    postimage=json['postimage'];
  }
  Map<String,dynamic>tomap(){
    return {
      'name':name,
      'image':image,
      'datetime':datetime,
      'text':text,
      'uId':uId,
      'postimage':postimage
    };
  }

}
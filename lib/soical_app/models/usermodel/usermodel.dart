class socialusermodel{
  String? name;
  String? email;
  String? phone;
  String? uId;
  String?image;
  String?cover;
  String?bio;
  bool? isemailverified;
  socialusermodel({this.name, this.email, this.phone, this.uId,this.isemailverified,this.image,this.bio,this.cover});
  socialusermodel.fromjson(Map<String,dynamic>json){
email=json['email'];
name=json['name'];
phone=json['phone'];
uId=json['uId'];
image=json['image'];
cover=json['cover'];
bio=json['bio'];
isemailverified=json['isemailverified'];
  }
  Map<String,dynamic>tomap(){
    return {
    'name':name,
    'phone':phone,
     'email':email,
      'image':image,
      'cover':cover,
      'bio':bio,
        'uId':uId,
      'isemailverified':isemailverified
  };
}

}
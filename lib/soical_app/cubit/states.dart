abstract class socialstates{}
class socialiniatestate extends socialstates{}
///////////////////getusers//////////////////////
class socialgetuserloadingstate extends socialstates{}
class socialgetusersucessstate extends socialstates{}
class socialgetuserfailedstate extends socialstates{
  final String error;

  socialgetuserfailedstate(this.error);
}
///////////////////getposts//////////////////////
class socialgetpostsloadingstate extends socialstates{}////
class socialgetpostssucessstate extends socialstates{}
class socialgetpostsfailedstate extends socialstates{
  final String error;

  socialgetpostsfailedstate(this.error);
}
///////////////////get users///////////////
class socialgetallusersloadingstate extends socialstates{}////
class socialgetalluserssucessstate extends socialstates{}
class socialgetallusersfailedstate extends socialstates{
  final String error;

  socialgetallusersfailedstate(this.error);
}
//////////likepost////////////////////
class sociallikepostssucessstate extends socialstates{}
class sociallikepostsfailedstate extends socialstates{
  final String error;

  sociallikepostsfailedstate(this.error);
}
/////////////////commentpost//////////
class socialcommentpostssucessstate extends socialstates{}
class socialcommentpostsfailedstate extends socialstates{
  final String error;

  socialcommentpostsfailedstate(this.error);
}
//////////////////
class socialchangenavbarstate extends socialstates{}
class socialnewpoststate extends socialstates{}
///////////////////get profileimage
class socialprofileimagegetsucsessstate extends socialstates{}
class socialprofileimagegetfailedstate extends socialstates{}
/////////////////////getcoverimage///////////////
class socialcoverimagegetsucsessstate extends socialstates{}
class socialcoverimagegetfailedstate extends socialstates{}
//////////////////uploadprofileimage////////////
class socialuploadprofileimagesucsessstate extends socialstates{}
class socialuploadprofileimagefailedstate extends socialstates{}
/////////////////uploadcoverimage//////////////
class socialuploadcoverimagesucsessstate extends socialstates{}
class socialuploadcoverimagefailedstate extends socialstates{}
/////////////////updateuserdate/////////////////
class socialuserupdateprofileloadingstate extends socialstates{}
class socialuserupdatecoverloadingstate extends socialstates{}
class socialuserupdatefailedstate extends socialstates{}
/////////////////////////////createpost
class socialcreatepostloadingstate extends socialstates{}
class socialcreatepostscusessstate extends socialstates{}
class socialcrearepostfailedstate extends socialstates{}
class socialnewpostloadingstate extends socialstates{}
class socialnewpostfailedstate extends socialstates{}
class socialgetpostsucsessstate extends socialstates{}
class socialgetpostfailedstate extends socialstates{}
class socialremovepostimagestate extends socialstates{}
/////////////////chats//////////
class socialsendmessagesucsessstate extends socialstates{}
class socialsendmessagefailedstate extends socialstates{}
class socialgetallmessagessucsessstate extends socialstates{}
class socialgetallmessagesfailedstate extends socialstates{}


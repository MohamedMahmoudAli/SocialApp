import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:udemy_project/soical_app/cubit/states.dart';
import 'package:udemy_project/soical_app/models/mesagemodel/messagemodel.dart';
import 'package:udemy_project/soical_app/models/postmodel/postmodel.dart';
import 'package:udemy_project/soical_app/models/usermodel/usermodel.dart';
import 'package:udemy_project/soical_app/modules/chats/chatsScreen.dart';
import 'package:udemy_project/soical_app/modules/feeds/feedsScreen.dart';
import 'package:udemy_project/soical_app/modules/newpost/newpost.dart';
import 'package:udemy_project/soical_app/modules/setting/settinScreen.dart';
import 'package:udemy_project/soical_app/modules/users/usersScreen.dart';
import 'package:udemy_project/soical_app/shared/compenets/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:udemy_project/soical_app/models/usermodel/usermodel.dart';

class socialcubit extends Cubit<socialstates> {
  socialcubit() : super(socialiniatestate());
  static socialcubit get(context) => BlocProvider.of(context);
  socialusermodel? usermodel;
  void getuserdata() {
    emit(socialgetuserloadingstate());
    FirebaseFirestore.instance.collection('users').doc(uid).get().then((value) {
      usermodel = socialusermodel.fromjson(value.data()!);
      print(value.data());
      emit(socialgetusersucessstate());
    }).catchError((error) {
      print(error.toString());
      emit(socialgetuserfailedstate(error.toString()));
    });
  }

  int currentindex = 0;
  List<Widget> screens = [
    feedScreen(),
    chatScreen(),
    newpostScreen(),
    usersScreen(),
    settingScreen(),
  ];
  List<String> titles = [
    'FeedScreen',
    'ChatScreen',
    'newpost',
    'UsersScreen,',
    'SettingScreen',
  ];
  void changenavbar(int index) {
    if(index==1)
      getusers();
    if (index == 2)
      emit(socialnewpoststate());
    else {
      currentindex = index;
      emit(socialchangenavbarstate());
    }
  }

  File? profileimage;
  final picker = ImagePicker();
  Future<void> getImage() async {
    final PickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (PickedFile != null) {
      profileimage = File(PickedFile.path);
      print(PickedFile.path);
      emit(socialprofileimagegetsucsessstate());
    } else {
      print('no image found');
      emit(socialprofileimagegetfailedstate());
    }
  }

  File? coverimage;
  Future<void> getcover() async {
    final PickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (PickedFile != null) {
      coverimage = File(PickedFile.path);
      emit(socialcoverimagegetsucsessstate());
    } else {
      print('no image found');
      emit(socialcoverimagegetfailedstate());
    }
  }

  void uploadprofileimage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(socialuserupdateprofileloadingstate());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileimage!.path).pathSegments.last}')
        .putFile(profileimage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        updateuser(name: name, phone: phone, bio: bio, image: value);
        //emit(socialuploadprofileimagesucsessstate());
      }).catchError((onError) {
        print(onError.toString());
        emit(socialuploadprofileimagefailedstate());
      });
    }).catchError((error) {
      print(error.toString());
      emit(socialuploadprofileimagefailedstate());
    });
  }

  void uploadcoverimage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(socialuserupdatecoverloadingstate());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverimage!.path).pathSegments.last}')
        .putFile(coverimage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        updateuser(
          name: name,
          phone: phone,
          bio: bio,
          profile: value,
        );
      }).catchError((onError) {
        print(onError.toString());
        emit(socialuploadcoverimagefailedstate());
      });
    }).catchError((error) {
      print(error.toString());
      emit(socialuploadcoverimagefailedstate());
    });
  }

//   void updateuserimage({
//   required String name,
//     required String phone,
//     required String bio
// }){
//     emit(socialuserupdateloadingstate());
//     if(coverimage!=null){
//       uploadcoverimage();
//     }
//     else if(profileimage!=null){
//       uploadprofileimage();
//     }else{
//       updateuser(name: name, phone: phone, bio: bio);
//
//     }
//
//   }
  void updateuser({
    required String name,
    required String phone,
    required String bio,
    String? image,
    String? profile,
  }) {
    socialusermodel model = socialusermodel(
        name: name,
        phone: phone,
        isemailverified: false,
        bio: bio,
        image: image ?? usermodel!.image,
        cover: profile ?? usermodel!.cover,
        uId: usermodel!.uId,
        email: usermodel!.email);

    FirebaseFirestore.instance
        .collection('users')
        .doc(model.uId)
        .update(model.tomap())
        .then((value) {
      getuserdata();
    }).catchError((onError) {
      emit(socialuserupdatefailedstate());
    });
  }

  void uploadpostimage({
    required String datetime,
    required String text,
  }) {
    emit(socialnewpostloadingstate());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(Postimage!.path).pathSegments.last}')
        .putFile(Postimage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        createpost(datetimetext: datetime, text: text, postimage: value);
      }).catchError((onError) {
        print(onError.toString());
        emit(socialnewpostfailedstate());
      });
    }).catchError((error) {
      print(error.toString());
      emit(socialnewpostfailedstate());
    });
  }

  File? Postimage;
  Future<void> getpostimage() async {
    final PickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (PickedFile != null) {
      Postimage = File(PickedFile.path);
      emit(socialgetpostsucsessstate());
    } else {
      print('no image found');
      emit(socialgetpostfailedstate());
    }
  }

  void removepostimage() {
    Postimage = null;
    emit(socialremovepostimagestate());
  }

  void createpost(
      {required String datetimetext, required String text, String? postimage}) {
    postmodel model = postmodel(
        name: usermodel!.name,
        image: usermodel!.image,
        uId: usermodel!.uId,
        text: text,
        postimage: postimage ?? '',
        datetime: datetimetext);
    FirebaseFirestore.instance
        .collection('posts')
        .add(model.tomap())
        .then((value) {
      emit(socialcreatepostscusessstate());
    }).catchError((onError) {
      emit(socialcrearepostfailedstate());
    });
  }

  List<postmodel> posts = [];
  List<String> postid = [];
  List<int> likes = [];
  List<int> comments = [];

  void getposts() {
    emit(socialgetpostsloadingstate());
    FirebaseFirestore.instance.collection('posts').snapshots().listen((event) {
      event.docs.forEach((element) {
        posts=[];
        element
            .reference
            .collection('likes')
            .get()
            .then((value) {
          likes.add(value.docs.length);
          postid.add(element.id);
          posts.add(postmodel.fromjson(element.data()));
        }).catchError(onError);
        element
            .reference
            .collection('comment')
            .get()
            .then((value) {
          comments.add(value.docs.length);
        }).catchError(onError);
      });

      emit(socialgetpostssucessstate());

    });
    //     .catchError((error) {
    //   emit(socialgetpostsfailedstate(error.toString()));
    // });
  }

  void likepost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(usermodel!.uId)
        .set({'like': true}).then((value) {
      emit(sociallikepostssucessstate());
    }).catchError((error) {
      emit(sociallikepostsfailedstate(error.toString()));
    });
  }

  void commentpost(String postId, String comment) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comment')
        .doc(usermodel!.uId)
        .set({'comment': comment}).then((value) {
      emit(sociallikepostssucessstate());
    }).catchError((error) {
      emit(sociallikepostsfailedstate(error.toString()));
    });
  }
  List<socialusermodel>users=[];
  void getusers() {
    emit(socialgetallusersloadingstate());
    users=[];
    if(users.length==0) {
      FirebaseFirestore.instance.collection('users').snapshots().listen((event) {
        event.docs.forEach((element) {
              if(element.data()['uId']!=usermodel!.uId) {
                users.add(socialusermodel.fromjson(element.data()));
              }
            });
        emit(socialgetalluserssucessstate());
      });
    //   get().then((value) {
    //   value.docs.forEach((element) {
    //     if(element.data()['uId']!=usermodel!.uId) {
    //       users.add(socialusermodel.fromjson(element.data()));
    //     }
    //   });
    //   emit(socialgetalluserssucessstate());
    // }).catchError((error) {
    //   emit(socialgetallusersfailedstate(error.toString()));
    // });
    // }
  }}
  void sendmessage({
  required String reciverid,
    required String datetime,
    required String text
}){
    messagemodel model=messagemodel(
      senderid: usermodel!.uId,
      reciverid: reciverid,
      datetime: datetime,
      text: text
    );
    FirebaseFirestore
        .instance
        .collection('users')
        .doc(usermodel!.uId)
        .collection('chats')
        .doc(reciverid)
        .collection('messages')
        .add(model.tomap())
        .then((value){
          emit(socialsendmessagesucsessstate());
    })
        .catchError((error){
      emit(socialsendmessagefailedstate());
    });
    FirebaseFirestore
        .instance
        .collection('users')
        .doc(reciverid)
        .collection('chats')
        .doc(usermodel!.uId)
        .collection('messages')
        .add(model.tomap())
        .then((value){
      emit(socialsendmessagesucsessstate());
    })
        .catchError((error){
      emit(socialsendmessagefailedstate());
    });
  }
  List<messagemodel>messages=[];
  void getmessages({required String reciverid,}){

    FirebaseFirestore
        .instance.collection('users')
        .doc(usermodel!.uId)
        .collection('chats')
        .doc(reciverid)
        .collection('messages')
    .orderBy('datetime')
        .snapshots()
        .listen((event) {
      messages=[];
          event.docs.forEach((element) {
            messages.add(messagemodel.fromjson(element.data()));
          });
          emit(socialgetallmessagessucsessstate());
    });
  }

}

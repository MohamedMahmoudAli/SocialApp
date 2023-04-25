import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_project/soical_app/cubit/cubit.dart';
import 'package:udemy_project/soical_app/cubit/states.dart';
import 'package:udemy_project/soical_app/modules/newpost/newpost.dart';
import 'package:udemy_project/soical_app/shared/compenets/components.dart';
import 'package:udemy_project/soical_app/shared/compenets/constants.dart';
import 'package:udemy_project/soical_app/shared/styles/icon_broken.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
class socialhomelayout extends StatelessWidget {
  const socialhomelayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<socialcubit,socialstates>(
     listener:(context,state){
       if(state is socialnewpoststate){
         navigateTo(context, newpostScreen());
       }
     },
        builder: (context,state){
       var cubit=socialcubit.get(context);
       return   Scaffold(
         appBar: AppBar(
           title: Text(cubit.titles[cubit.currentindex],
           ),
           actions: [
             IconButton(onPressed: (){}, icon: const Icon(
               IconBroken.Notification
             )),
             IconButton(onPressed: (){}, icon: const Icon(
                 IconBroken.Search
             )),
             IconButton(onPressed: (){
               uid=null;
               navigateAndFinish(context, socialloginscreen);
             }, icon: const Icon(
                 IconBroken.Logout
             )),

           ],
         ),
         body:cubit.screens[cubit.currentindex],
         bottomNavigationBar: AnimatedBottomNavigationBar(
           elevation: 50,
           activeIndex: cubit.currentindex,
           onTap: (index){
             cubit.changenavbar(index);
           },
           icons: [
               IconBroken.Home,
             IconBroken.Chat,
             IconBroken.Paper_Upload,
             IconBroken.Location,
             IconBroken.Setting
           ],
           activeColor: Colors.blue,
           splashColor: Colors.blue,
           inactiveColor: Colors.black,
           iconSize: 30.0,
           gapLocation: GapLocation.none,
           notchSmoothness: NotchSmoothness.smoothEdge,
           leftCornerRadius: 32,
           rightCornerRadius: 32,
           // items: const [
           //   BottomNavigationBarItem(icon:Icon(
           //     IconBroken.Home,
           //   ),label: 'Home'),
           //   BottomNavigationBarItem(icon:Icon(
           //       IconBroken.Chat
           //   ),label: 'Chat'),
           //   BottomNavigationBarItem(icon:Icon(
           //       IconBroken.Paper_Upload
           //   ),label: 'post'),
           //   BottomNavigationBarItem(icon:Icon(
           //       IconBroken.Location
           //   ),label: 'User'),
           //   BottomNavigationBarItem(icon:Icon(
           //       IconBroken.Setting
           //   ),label: 'Setting'),
           // ],
         ),

       );
        },
    );


  }
}
// ConditionalBuilder(
// condition:socialcubit.get(context).model!=null,
// builder:(context){
// var model =socialcubit.get(context).model;
// return Column(
// children: [
// if(!FirebaseAuth.instance.currentUser!.emailVerified)
// Container(
// height: 50,
// color: Colors.amber.withOpacity(.5),
// child:Padding(
// padding: EdgeInsetsDirectional.all(10),
// child:Row(
// children: [
// Icon(Icons.info_outline),
// Text('please verfiy your email'),
// Spacer(),
// textButton(function: (){
// FirebaseAuth.instance.currentUser!.sendEmailVerification().then((value) {
// ShowToast(text: 'check your email', state:ToastStates.SUCCESS);
// }).catchError((error){
// print(error.toString());
// });
// }, text: 'send ',width: 220)
// ],
// ),)
// )
// ],
// );},
// fallback: (context)=>Center(child: CircularProgressIndicator()),
//
// )
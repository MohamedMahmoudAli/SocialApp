import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_project/soical_app/cubit/cubit.dart';
import 'package:udemy_project/soical_app/cubit/states.dart';
import 'package:udemy_project/soical_app/modules/editProfile/editprofile.dart';
import 'package:udemy_project/soical_app/shared/compenets/components.dart';

import '../../shared/styles/icon_broken.dart';
class settingScreen extends StatelessWidget {
  const settingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<socialcubit,socialstates>(
      listener: (state,context){},
      builder: (context,state){
        var usermodel=socialcubit.get(context).usermodel;
        return Padding(padding: EdgeInsets.all(9),
            child:Column(
              children: [
                Container(
                  height: 180,
                  child: Stack(
                    alignment:AlignmentDirectional.bottomCenter ,
                    children: [
                      Align(
                        alignment:AlignmentDirectional.topCenter ,
                        child: Container(
                          // color: Colors.grey,
                          height: 140,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(8),
                                topRight:  Radius.circular(8),
                              ),
                              image: DecorationImage(
                                  image: NetworkImage(
                                      '${usermodel!.cover}'),
                                  fit: BoxFit.cover)),
                        ),
                      ),
                      CircleAvatar(
                        radius: 63,
                        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                        child: CircleAvatar(
                          radius: 60,
                          backgroundImage: NetworkImage(
                              '${usermodel.image}'),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 5,),
                Text('${usermodel.name}',
                  style: Theme.of(context).textTheme.bodyText1,),
                SizedBox(height: 5,),
                Text('${usermodel.bio}',
                  style: Theme.of(context).textTheme.caption,),
                Padding(padding: EdgeInsets.symmetric(
                    vertical: 20
                ),
                  child:Row(
                    children: [
                      Expanded(
                          child:InkWell(
                            child:Column(
                              children: [
                                Text('100 ',
                                  style: Theme.of(context).textTheme.subtitle1,),
                                SizedBox(height: 5,),
                                Text('post',
                                  style: Theme.of(context).textTheme.caption,),
                              ],
                            ),
                            onTap: (){},
                          )
                      ),
                      Expanded(
                          child:InkWell(
                            child:Column(
                              children: [
                                Text('256 ',
                                  style: Theme.of(context).textTheme.subtitle1,),
                                SizedBox(height: 5,),
                                Text('photos',
                                  style: Theme.of(context).textTheme.caption,),
                              ],
                            ),
                            onTap: (){},
                          )
                      ),
                      Expanded(
                          child:InkWell(
                            child:Column(
                              children: [
                                Text('10K ',
                                  style: Theme.of(context).textTheme.subtitle1,),
                                SizedBox(height: 5,),
                                Text('Followers',
                                  style: Theme.of(context).textTheme.caption,),
                              ],
                            ),
                            onTap: (){},
                          )
                      ),
                      Expanded(
                          child:InkWell(
                            child:Column(
                              children: [
                                Text('34 ',
                                  style: Theme.of(context).textTheme.subtitle1,),
                                SizedBox(height: 5,),
                                Text('following',
                                  style: Theme.of(context).textTheme.caption,),
                              ],
                            ),
                            onTap: (){},
                          )
                      ),
                    ],
                  ) ,
                ),
                Row(
                  children: [
                    Expanded(
                        child:OutlinedButton(
                          child: Text('Add photo'),
                          onPressed: (){},
                        ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    OutlinedButton(
                        child: Icon(
                          IconBroken.Edit,
                          size: 19,
                        ),
                        onPressed: (){
                          navigateTo(context, editprofileScreen());
                        },
                      ),
                  ],
                ),
                Row(
                  children: [
                    OutlinedButton(
                        onPressed: (){
                          FirebaseMessaging.instance.subscribeToTopic('announcement');
                        }, child: Text('subscribe')),
                    SizedBox(width: 25,),
                    OutlinedButton(onPressed: (){
                      FirebaseMessaging.instance.unsubscribeFromTopic('announcement');
                    }, child: Text('unsubscribe')),

                  ],
                )
              ],
            ));
      },
    );
  }
}

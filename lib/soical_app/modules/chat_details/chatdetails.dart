import 'package:flutter/material.dart';
import 'package:udemy_project/soical_app/cubit/cubit.dart';
import 'package:udemy_project/soical_app/cubit/states.dart';
import 'package:udemy_project/soical_app/models/mesagemodel/messagemodel.dart';
import 'package:udemy_project/soical_app/models/usermodel/usermodel.dart';
import 'package:udemy_project/soical_app/shared/compenets/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

import '../../shared/styles/icon_broken.dart';

class chatdetails extends StatelessWidget {
  var messagecontroler=TextEditingController();
  socialusermodel usermodel;
  chatdetails({required this.usermodel});
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context){
      socialcubit.get(context).getmessages(reciverid: usermodel.uId!);
      return BlocConsumer<socialcubit,socialstates>(
        listener: (context,state){},
        builder: (context,state){
          return  Scaffold(
            appBar: AppBar(
              titleSpacing: 0,
              title: Row(
                children: [
                  CircleAvatar(
                    radius: 15,
                    backgroundImage: NetworkImage('${usermodel.image}'),
                  ),
                  SizedBox(width: 5,),
                  Text('${usermodel.name}')
                ],
              ),

            ),
            body: ConditionalBuilder(
                condition: socialcubit.get(context).messages.length>0,
                builder: (context)=> Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                     Expanded(
                       child: ListView.separated(
                         shrinkWrap: true,
                           physics: NeverScrollableScrollPhysics(),
                           itemBuilder: (context,index){
                             var message=socialcubit.get(context).messages[index];
                             if(socialcubit.get(context).usermodel!.uId==message.senderid)
                             return buildmymessage(message);
                             return buildmessage(message);
                           }, separatorBuilder: (context,index)=>Padding(padding: EdgeInsets.symmetric(vertical: 3)),
                           itemCount: socialcubit.get(context).messages.length),
                     ),
                      Spacer(),
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.grey,
                                width: 1
                            ),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child:
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: messagecontroler,
                                decoration:InputDecoration(
                                    border: InputBorder.none,
                                    hintText: ' type your mesage here..'
                                ),
                              ),
                            ),
                            Container(
                              height: 50,
                              color: DefaultColor,
                              child: MaterialButton(
                                onPressed: (){
                                  socialcubit.get(context).sendmessage(
                                      reciverid: usermodel.uId!,
                                      datetime: DateTime.now().toString(),
                                      text: messagecontroler.text);
                                },
                                minWidth: 1,
                                child: Icon(
                                  IconBroken.Send,
                                  size: 20,
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                fallback:(context)=>Center(child:CircularProgressIndicator()) )
          );
        },
      );
    });
  }
  Widget buildmessage(messagemodel model)=>Align(
    alignment: AlignmentDirectional.centerStart,
    child: Container(
      decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadiusDirectional.only(
            topEnd: Radius.circular(10),
            topStart: Radius.circular(10),
            bottomEnd: Radius.circular(10),
          )
      ),
      padding: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5
      ),
      child: Text('${model.text} '),
    ),
  );
  Widget buildmymessage(messagemodel model)=>Align(
    alignment: AlignmentDirectional.centerEnd,
    child: Container(
      decoration: BoxDecoration(
          color: DefaultColor.withOpacity(.3),
          borderRadius: BorderRadiusDirectional.only(
            topEnd: Radius.circular(10),
            topStart: Radius.circular(10),
            bottomStart: Radius.circular(10),
          )
      ),
      padding: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5
      ),
      child: Text('${model.text} '),
    ),
  );
}

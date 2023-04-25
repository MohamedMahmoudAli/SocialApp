import 'package:flutter/material.dart';
import 'package:udemy_project/soical_app/cubit/cubit.dart';
import 'package:udemy_project/soical_app/cubit/states.dart';
import 'package:udemy_project/soical_app/shared/compenets/components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/styles/icon_broken.dart';
class newpostScreen extends StatelessWidget {
  const newpostScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textcontroller=TextEditingController();
    var usermodel=socialcubit.get(context).usermodel;
    return BlocConsumer<socialcubit,socialstates>
      (
      listener: (context,state){},
      builder:  (context,state){
        return Scaffold(
            appBar: defaultappbar(context: context
                ,title: 'Create Post',
                actions: [

                  defaultTextButton(function: (){
                    var now=DateTime.now();
                    if(socialcubit.get(context).Postimage==null){
                      socialcubit.get(context).createpost(
                          datetimetext:now.toString() ,
                          text: textcontroller.text);
                    }else{
                      socialcubit.get(context).uploadpostimage(

                          datetime: now.toString(),
                          text: textcontroller.text);
                    }
                  }, text: 'Post',)
                ]
            ),
            body:Padding(
              padding: EdgeInsets.all(20),
              child:  Column(
                children: [
                  if(state is socialcreatepostloadingstate)
                  LinearProgressIndicator(),
                  SizedBox(height: 5,),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage(
                            '${usermodel!.image}'),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${usermodel.name}',
                                style: TextStyle(height: 1.5),
                              ),

                            ],
                          )),
                      SizedBox(
                        width: 20,
                      ),

                    ],
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: textcontroller,
                      decoration: InputDecoration(
                        hintText: 'What\'s in your mind',
                        border: InputBorder.none
                      ),
                    ),
                  ),
                  if(socialcubit.get(context).Postimage!=null)
                  Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Container(
                        height: 140,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8),
                            ),
                            image: DecorationImage(
                                image:FileImage(socialcubit.get(context).Postimage!) ,
                                fit: BoxFit.cover)),
                      ),
                      IconButton(
                          onPressed: () {
                            socialcubit.get(context).removepostimage();
                          },
                          icon: CircleAvatar(
                              radius: 20,
                              child: Icon(
                                Icons.close,
                                size: 18,
                              )))
                    ],
                  ),
                  SizedBox(height: 30,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          child: TextButton(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                              Icon(IconBroken.Image),
                              SizedBox(width: 10,),
                              Text('Add Photo')
                            ],),
                            onPressed: (){
                              socialcubit.get(context).getpostimage();
                            },
                          
                          )),
                      Expanded(
                          child: TextButton(
                            child: Text('# Tags'),
                            onPressed: (){},

                          ))
                    ],
                  )
                ],
              ),

            )

        );
      },

    );
  }
}

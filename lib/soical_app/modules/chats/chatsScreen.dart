

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_project/soical_app/cubit/cubit.dart';
import 'package:udemy_project/soical_app/cubit/states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:udemy_project/soical_app/models/usermodel/usermodel.dart';
import 'package:udemy_project/soical_app/modules/chat_details/chatdetails.dart';
import 'package:udemy_project/soical_app/shared/compenets/components.dart';
import 'package:udemy_project/soical_app/shared/compenets/constants.dart';
class chatScreen extends StatelessWidget {
  const chatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<socialcubit,socialstates>(
      listener: (context,state){},
        builder: (context,state){
        return ConditionalBuilder(
            condition:state is!socialgetallusersloadingstate,
            builder: (context)=>ListView.separated(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context,index)=>buildItem(context,socialcubit.get(context).users[index] ),
                separatorBuilder: (context,index)=>Padding(padding: EdgeInsets.symmetric(vertical: 3)),
                itemCount: socialcubit.get(context).users.length),
            fallback: (context)=>const Center(child: CircularProgressIndicator(),));
        } );
  }
  Widget buildItem(context,socialusermodel model)=>InkWell(
    child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage('${model.image}'),
          ),
          const SizedBox(
            width: 20,
          ),
          Text(
            '${model.name}',
            style: TextStyle(height: 1.5),
          ),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
    ),
    onTap: (){
      navigateTo(
          context,
          chatdetails(usermodel: model));
    },
  );
}

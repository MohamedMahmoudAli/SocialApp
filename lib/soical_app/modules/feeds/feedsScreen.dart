import 'package:flutter/material.dart';
import 'package:udemy_project/soical_app/cubit/cubit.dart';
import 'package:udemy_project/soical_app/cubit/states.dart';
import 'package:udemy_project/soical_app/models/postmodel/postmodel.dart';
import 'package:udemy_project/soical_app/shared/compenets/constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

import '../../shared/styles/icon_broken.dart';

class feedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<socialcubit, socialstates>(
        listener: (context, state) {},
        builder: (context, state) {
          return ConditionalBuilder(
            condition: socialcubit.get(context).posts.length>0,
            builder: (context) => SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    elevation: 5.0,
                    margin: EdgeInsets.all(
                      12.0,
                    ),
                    child: Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          const Image(
                            image: NetworkImage(
                                'https://img.freepik.com/free-photo/dreamy-woman-love-recalls-perfect-date-with-boyfriend-thinks-about-cute-sweet-things-keeps-hands-neck-looks-somewhere-wears-green-sweater_273609-38781.jpg?t=st=1662646188~exp=1662646788~hmac=9bb132e88ca2983a636ac05579df2f29bf2d3289361531ea1804a6a49ccd5206'),
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          Padding(
                            padding: EdgeInsetsDirectional.all(10),
                            child: Text('Comunicte with friends',
                                style: Theme.of(context).textTheme.subtitle1),
                          ),
                        ]),
                  ),
                  ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) => buildPostItem(
                        socialcubit.get(context).posts[index], index, context),
                    separatorBuilder: (context, index) => Padding(
                      padding: EdgeInsets.all(5),
                      child: Container(
                        color: Colors.grey,
                      ),
                    ),
                    itemCount: socialcubit.get(context).posts.length,
                  )
                ],
              ),
            ),
            fallback: (context) => Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}

Widget buildPostItem(postmodel model, index, context) {
  var commentcontroler = TextEditingController();
  return Card(
    margin: EdgeInsets.symmetric(horizontal: 10),
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 10,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage('${model.image}'),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        '${model.name}',
                        style: TextStyle(height: 1.5),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Icon(
                        Icons.check_circle,
                        size: 16,
                        color: DefaultColor,
                      ),
                    ],
                  ),
                  Text(
                    '${model.datetime}',
                    style: Theme.of(context)
                        .textTheme
                        .caption!
                        .copyWith(height: 1.5),
                  )
                ],
              )),
              SizedBox(
                width: 20,
              ),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.more_horiz,
                    size: 16,
                  ))
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Container(
              width: double.infinity,
              height: 1,
              color: Colors.grey[500],
            ),
          ),
          Text(
            '${model.text}',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(vertical: 10),
          //   child: Container(
          //     width: double.infinity,
          //     child: Wrap(
          //       children: [
          //         Padding(
          //           padding: const EdgeInsetsDirectional.only(end: 6),
          //           child: Container(
          //             height: 20,
          //             child: MaterialButton(
          //               onPressed: () {},
          //               minWidth: 1,
          //               padding: EdgeInsets.zero,
          //               child: Text(
          //                 '#software',
          //                 style: TextStyle(color: Colors.blue),
          //               ),
          //             ),
          //           ),
          //         ),
          //         Padding(
          //           padding: const EdgeInsetsDirectional.only(end: 6),
          //           child: Container(
          //             height: 20,
          //             child: MaterialButton(
          //               onPressed: () {},
          //               minWidth: 1,
          //               padding: EdgeInsets.zero,
          //               child: Text(
          //                 '#flutter',
          //                 style: TextStyle(color: Colors.blue),
          //               ),
          //             ),
          //           ),
          //         ),
          //         Padding(
          //           padding: const EdgeInsetsDirectional.only(end: 6),
          //           child: Container(
          //             height: 20,
          //             child: MaterialButton(
          //               onPressed: () {},
          //               minWidth: 1,
          //               padding: EdgeInsets.zero,
          //               child: Text(
          //                 '#software',
          //                 style: TextStyle(color: Colors.blue),
          //               ),
          //             ),
          //           ),
          //         ),
          //         Padding(
          //           padding: const EdgeInsetsDirectional.only(end: 6),
          //           child: Container(
          //             height: 20,
          //             child: MaterialButton(
          //               onPressed: () {},
          //               minWidth: 1,
          //               padding: EdgeInsets.zero,
          //               child: Text(
          //                 '#software',
          //                 style: TextStyle(color: Colors.blue),
          //               ),
          //             ),
          //           ),
          //         ),
          //         Padding(
          //           padding: const EdgeInsetsDirectional.only(end: 6),
          //           child: Container(
          //             height: 20,
          //             child: MaterialButton(
          //               onPressed: () {},
          //               minWidth: 1,
          //               padding: EdgeInsets.zero,
          //               child: Text(
          //                 '#software',
          //                 style: TextStyle(color: Colors.blue),
          //               ),
          //             ),
          //           ),
          //         ),
          //         Padding(
          //           padding: const EdgeInsetsDirectional.only(end: 6),
          //           child: Container(
          //             height: 20,
          //             child: MaterialButton(
          //               onPressed: () {},
          //               minWidth: 1,
          //               padding: EdgeInsets.zero,
          //               child: Text(
          //                 '#software',
          //                 style: TextStyle(color: Colors.blue),
          //               ),
          //             ),
          //           ),
          //         ),
          //         Padding(
          //           padding: const EdgeInsetsDirectional.only(end: 6),
          //           child: Container(
          //             height: 20,
          //             child: MaterialButton(
          //               onPressed: () {},
          //               minWidth: 1,
          //               padding: EdgeInsets.zero,
          //               child: Text(
          //                 '#software',
          //                 style: TextStyle(color: Colors.blue),
          //               ),
          //             ),
          //           ),
          //         ),
          //         Padding(
          //           padding: const EdgeInsetsDirectional.only(end: 6),
          //           child: Container(
          //             height: 20,
          //             child: MaterialButton(
          //               onPressed: () {},
          //               minWidth: 1,
          //               padding: EdgeInsets.zero,
          //               child: Text(
          //                 '#software_devlopment',
          //                 style: TextStyle(color: Colors.blue),
          //               ),
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          if (model.postimage != '')
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Container(
                // color: Colors.grey,
                height: 120,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    image: DecorationImage(
                        image: NetworkImage('${model.postimage}'),
                        fit: BoxFit.cover)),
              ),
            ),
          Padding(
            padding: EdgeInsets.all(7),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    child: Row(
                      children: [
                        Icon(
                          IconBroken.Heart,
                          size: 20,
                          color: Colors.red,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          '${socialcubit.get(context).likes[index]}',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                    onTap: () {},
                  ),
                ),
                Expanded(
                  child: InkWell(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          IconBroken.Chat,
                          size: 20,
                          color: Colors.red,
                        ),
                        Text(
                          '${socialcubit.get(context).comments[index]}  Comment',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                    onTap: () {},
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Container(
              width: double.infinity,
              height: 1,
              color: Colors.grey[500],
            ),
          ),
          Row(
            children: [
              InkWell(
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 18,
                      backgroundImage: NetworkImage(
                          '${socialcubit.get(context).usermodel!.image}'),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Container(
                      width: 250,
                      child: TextFormField(
                        controller: commentcontroler,
                        decoration: InputDecoration(
                          labelText: 'coment',
                          suffixIcon: Icon(IconBroken.Edit),
                          border: InputBorder.none,
                        ),
                        onFieldSubmitted: (value) {
                          socialcubit.get(context).commentpost(
                              socialcubit.get(context).postid[index], value);
                        },
                      ),
                    )
                  ],
                ),
                onTap: () {},
              ),
              const Spacer(),
              InkWell(
                child: Row(
                  children: [
                    const Icon(
                      IconBroken.Heart,
                      size: 20,
                      color: Colors.red,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Like',
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ],
                ),
                onTap: () {
                  socialcubit
                      .get(context)
                      .likepost(socialcubit.get(context).postid[index]);
                },
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

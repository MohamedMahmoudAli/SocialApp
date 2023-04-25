import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:udemy_project/soical_app/cubit/cubit.dart';
import 'package:udemy_project/soical_app/cubit/states.dart';
import 'package:udemy_project/soical_app/shared/compenets/components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/styles/icon_broken.dart';

class editprofileScreen extends StatelessWidget {
  var namecontroler = TextEditingController();
  var biocontroler = TextEditingController();
  var phonecontroler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<socialcubit, socialstates>(
      listener: (context, state) {},
      builder: (context, state) {
        var usermodel = socialcubit.get(context).usermodel;
        var profileimage = socialcubit.get(context).profileimage;
        var coverimage = socialcubit.get(context).coverimage;
        namecontroler.text = usermodel!.name!;
        biocontroler.text = usermodel.bio!;
        phonecontroler.text = usermodel.phone!;

        return Scaffold(
          appBar:
              defaultappbar(context: context, title: 'Edit Profile', actions: [
            defaultTextButton(
                function: () {
                  socialcubit.get(context).updateuser(
                      name: namecontroler.text,
                      phone: phonecontroler.text,
                      bio: biocontroler.text);
                },
                text: 'UpDate')
          ]),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Container(
                    height: 180,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                            alignment: AlignmentDirectional.topCenter,
                            child: Stack(
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
                                          image: coverimage == null
                                              ? NetworkImage(
                                                  '${usermodel.cover}')
                                              : FileImage(coverimage)
                                                  as ImageProvider,
                                          fit: BoxFit.cover)),
                                ),
                                IconButton(
                                    onPressed: () {
                                      socialcubit.get(context).getcover();
                                    },
                                    icon: CircleAvatar(
                                        radius: 20,
                                        child: Icon(
                                          IconBroken.Camera,
                                          size: 18,
                                        )))
                              ],
                            )),
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            CircleAvatar(
                              radius: 63,
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              child: CircleAvatar(
                                radius: 60,
                                backgroundImage: profileimage == null
                                    ? NetworkImage('${usermodel.image}')
                                    : FileImage(profileimage) as ImageProvider,
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  socialcubit.get(context).getImage();
                                },
                                icon: CircleAvatar(
                                    radius: 20,
                                    child: Icon(
                                      IconBroken.Camera,
                                      size: 18,
                                    )))
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  if (socialcubit.get(context).coverimage != null ||
                      socialcubit.get(context).profileimage != null)
                    Row(
                      children: [
                        if (socialcubit.get(context).profileimage != null)
                          Expanded(
                              child: Column(
                            children: [
                              textButton(
                                  function: () {
                                    socialcubit.get(context).uploadprofileimage(
                                        name: namecontroler.text,
                                        phone: phonecontroler.text,
                                        bio: biocontroler.text);
                                  },
                                  text: 'Upload profile'),
                              if (state is socialuserupdateprofileloadingstate)
                                const LinearProgressIndicator(),
                            ],
                          )),
                        const SizedBox(
                          width: 5,
                        ),
                        if (socialcubit.get(context).coverimage != null)
                          Expanded(
                              child: Column(
                            children: [
                              textButton(
                                  function: () {
                                    socialcubit.get(context).uploadcoverimage(
                                        name: namecontroler.text,
                                        phone: phonecontroler.text,
                                        bio: biocontroler.text);
                                  },
                                  text: 'Upload cover'),
                              if (state is socialuserupdatecoverloadingstate)
                               const  LinearProgressIndicator(),
                            ],
                          ))
                      ],
                    ),
                  const SizedBox(
                    height: 10,
                  ),
                  defaultFormField(
                      controller: namecontroler,
                      type: TextInputType.name,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return 'the name must not be empty';
                        }
                        return null;
                      },
                      label: 'Name',
                      prefix: IconBroken.User),
                  const SizedBox(
                    height: 10,
                  ),
                  defaultFormField(
                      controller: biocontroler,
                      type: TextInputType.name,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return 'the bio must not be empty';
                        }
                        return null;
                      },
                      label: 'Bio',
                      prefix: IconBroken.Info_Circle),
                  SizedBox(
                    height: 10,
                  ),
                  defaultFormField(
                      controller: phonecontroler,
                      type: TextInputType.name,
                      validate: (String value) {
                        if (value.isEmpty) {
                          return 'the phone must not be empty';
                        }
                        return null;
                      },
                      label: 'Phone',
                      prefix: IconBroken.Call)
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// ignore_for_file: use_key_in_widget_constructors, must_be_immutable, missing_required_param, prefer_const_constructors, avoid_print

import 'dart:io';

import 'package:udemy_project/soical_app/layout/homelayout/homelayout.dart';
import 'package:udemy_project/soical_app/modules/loginscreen/socialloginscreen.dart';
import 'package:udemy_project/soical_app/modules/social_register/cubit/state.dart';
import 'package:udemy_project/soical_app/shared/compenets/components.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:udemy_project/soical_app/modules/social_register/cubit/cubit.dart';

class socialRegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  File? profileImage;
  var pickerController = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => socialRegisterCubit(),
      child: BlocConsumer<socialRegisterCubit, socialRegisterState>(
        listener: (context, state) {
          if (state is socialusercreateSuccessState) {
            navigateAndFinish(context, socialhomelayout());
          //   if (state.socialloginModel.status!) {
          //     // ShowToast(
          //     //   text: state.loginModel.message!,
          //     //   state: ToastStates.SUCCESS,
          //     // );
          //     // print(state.loginModel.message);
          //     // print(state.loginModel.data!.token);
          //     // CacheHelper.saveData(
          //     //     key: "token", value: state.loginModel.data!.token)
          //     //     .then((value) {
          //     //   token = state.loginModel.data!.token!;
          //     //   navigateAndFinish(context, HomeScreen());
          //     // });
          //   } else {
          //     // ShowToast(
          //     //   // text: state.loginModel.message!,
          //     //   state: ToastStates.ERROR,
          //     // );
          //     // print(state.loginModel.message);
          //   }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Register'),
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start ,
                        children: [
                          Text('Register Now',
                            style: GoogleFonts.lobster(
                              fontSize: 30.0,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                      Text(
                        "Rgister Now to communicate with firends",
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      defaultFormField(
                        controller: nameController,
                        type: TextInputType.name,
                        prefix: Icons.person,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'Please enter name';
                          }
                          return null;
                        },
                        label: 'Name',
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      defaultFormField(
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        prefix: Icons.email,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'Please enter email';
                          }
                          return null;
                        },
                        label: 'Email',
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      defaultFormField(
                        controller: phoneController,
                        type: TextInputType.phone,
                        prefix: Icons.phone,
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'Please enter phone';
                          }
                          return null;
                        },
                        label: 'Phone',
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      defaultFormField(
                        controller: passwordController,
                        type: TextInputType.visiblePassword,
                        prefix: Icons.key,
                        suffix: socialRegisterCubit.get(context).suffix,
                        isPassword: socialRegisterCubit.get(context).isPassword,
                        suffixPressed: () {
                          socialRegisterCubit.get(context).ChangePassword();
                        },
                        validate: (String? value) {
                          if (value!.isEmpty) {
                            return 'Please enter password';
                          }
                          return null;
                        },
                        label: 'Password',

                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ConditionalBuilder(
                        condition: state is! socialRegisterLoadingState,
                        builder: (context) => Center(
                          child: defaultMaterialButton(
                                 function: () {
                                  if (formKey.currentState!.validate()) {
                                    socialRegisterCubit.get(context).UserRegister(
                                      email: emailController.text,
                                      password: passwordController.text,
                                      name: nameController.text,
                                      phone: phoneController.text,
                                    );
                                  }
                                  },
                              text: 'Register',
                              radius: 20),
                        ),
                        fallback: (context) =>
                            Center(child: CircularProgressIndicator()),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                     Row(
                       children: [
                         Text('Already have acount'
                           ,style: GoogleFonts.lobster(
                           fontSize: 20.0,
                           color: Colors.black,
                           fontWeight: FontWeight.w600,
                         ),),
                         TextButton(onPressed: (){
                           navigateTo(context, Loginscreen());
                         }, child: Text('Login'
                           ,style: GoogleFonts.lobster(
                             fontSize: 20.0,
                             color: Colors.black,
                             fontWeight: FontWeight.w600,
                           ),))
                       ],
                     )
                    ]),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
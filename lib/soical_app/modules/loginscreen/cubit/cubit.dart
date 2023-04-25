// ignore_for_file: unnecessary_import, camel_case_types, non_constant_identifier_names, duplicate_ignore

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_project/soical_app/models/login/login_model.dart';
import 'package:udemy_project/soical_app/modules/loginscreen/cubit/state.dart';
import 'package:firebase_auth/firebase_auth.dart';

class socialloginCubit extends Cubit<socialLoginState> {
  socialloginCubit() : super(socialLoginInitialState());
  static socialloginCubit get(context) => BlocProvider.of(context);

  LoginModel? loginModel;

  void UserLogin({required String email, required String password}) {
    emit(socialLoginLoadingState());
    FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
          emit(socialLoginSuccessState(value.user!.uid));
    }).catchError((error){
      print(error.toString());
      emit(socialLoginErrorState(error));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void ChangePassword() {
    isPassword = !isPassword;
    suffix =
    isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(socialChangePasswordState());
  }
}
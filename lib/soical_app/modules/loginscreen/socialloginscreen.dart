import 'package:flutter/material.dart';
import 'package:udemy_project/soical_app/layout/homelayout/homelayout.dart';
import 'package:udemy_project/soical_app/modules/RestPasswordScreen/RestPasswordScreen.dart';
import 'package:udemy_project/soical_app/modules/loginscreen/Auth_phone/Authphone.dart';
import 'package:udemy_project/soical_app/modules/loginscreen/cubit/cubit.dart';
import 'package:udemy_project/soical_app/shared/cashehelper.dart';
import 'package:udemy_project/soical_app/shared/compenets/components.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:udemy_project/soical_app/modules/loginscreen/cubit/state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../social_register/socialregister_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class Loginscreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => socialloginCubit(),
      child: BlocConsumer<socialloginCubit, socialLoginState>(
        listener: (context, state) {
          if (state is socialLoginErrorState) {
            ShowToast(text: state.error, state: ToastStates.ERROR);
          }
          if (state is socialLoginSuccessState) {
            CacheHelper.saveData(key: "uid", value: state.uid).then((value) {
              navigateAndFinish(context, socialhomelayout());
            });
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
            ),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Sign In Now",
                          style: GoogleFonts.lobster(
                            fontSize: 30.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
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
                        const SizedBox(
                          height: 20,
                        ),
                        defaultFormField(
                          controller: passwordController,
                          type: TextInputType.visiblePassword,
                          prefix: Icons.key,
                          suffix: socialloginCubit.get(context).suffix,
                          isPassword: socialloginCubit.get(context).isPassword,
                          suffixPressed: () {
                            socialloginCubit.get(context).ChangePassword();
                          },
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'Please enter password';
                            }
                            return null;
                          },
                          label: 'Password',
                        ),
                        textButton(
                          function: () {
                            navigateTo(context, RestPasswordScreen());
                          },
                          text: "Forgotten password?",
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ConditionalBuilder(
                          condition: state is! socialLoginLoadingState,
                          builder: (context) => Center(
                            child: defaultMaterialButton(
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  socialloginCubit.get(context).UserLogin(
                                      email: emailController.text,
                                      password: passwordController.text);
                                }
                              },
                              text: 'Login',
                            ),
                          ),
                          fallback: (context) =>
                              Center(child: CircularProgressIndicator()),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            const Text(
                              'Don\'t have an account?',
                              style:
                                  TextStyle(fontSize: 16, color: Colors.grey),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            textButton(
                              function: () {
                                navigateTo(context, socialRegisterScreen());
                              },
                              text: 'Register Now!',
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 60.0,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.1),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(20.0),
                                    topRight: Radius.circular(20.0),
                                    bottomLeft: Radius.circular(20.0),
                                    bottomRight: Radius.circular(20.0),
                                  ),
                                ),
                                child: InkWell(
                                  child: Image(
                                    image: AssetImage(
                                        'assets/matgar_assets/assets/icons/google.png'),
                                    fit: BoxFit.none,
                                  ),
                                  onTap: () {},
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 20.0,
                            ),
                            Expanded(
                              child: Container(
                                height: 60.0,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.1),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(20.0),
                                    topRight: Radius.circular(20.0),
                                    bottomLeft: Radius.circular(20.0),
                                    bottomRight: Radius.circular(20.0),
                                  ),
                                ),
                                child: InkWell(
                                  child:  CircleAvatar(
                                    backgroundImage: const AssetImage(
                                      'assets/images/phone.png',
                                    ),
                                    radius: 30),
                                  onTap: () {
                                    // navigateTo(context, AuthPhone());
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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

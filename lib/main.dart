
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_project/soical_app/cubit/cubit.dart';
import 'package:udemy_project/soical_app/layout/homelayout/homelayout.dart';
import 'package:udemy_project/soical_app/modules/loginscreen/socialloginscreen.dart';
import 'package:udemy_project/soical_app/shared/bloc_observer.dart';
import 'package:udemy_project/soical_app/shared/compenets/components.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:udemy_project/soical_app/shared/cashehelper.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'soical_app/modules/OnBoarding/OnBoarding.dart';
import 'soical_app/shared/compenets/constants.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:udemy_project/soical_app/shared/mode_cubit/cubit.dart';

import 'soical_app/shared/mode_cubit/state.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {

  print('on back ground message');
  print(message.data.toString());
  ShowToast(text: 'on back ground message',state: ToastStates.SUCCESS);
}
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
   // diohelper.init();
    await CacheHelper.init();
  await Firebase.initializeApp();
  await FirebaseAppCheck.instance.activate(
    webRecaptchaSiteKey: 'recaptcha-v3-site-key',
  );
  var token =await FirebaseMessaging.instance.getToken();
  print(token);
  FirebaseMessaging.onMessage.listen((event) {
    print(event.data.toString());
    ShowToast(text: 'on message',state: ToastStates.SUCCESS);
  });
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print(event.data.toString());
    ShowToast(text: 'on message opened app',state: ToastStates.SUCCESS);
  });
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: true,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  print('User granted permission: ${settings.authorizationStatus}');
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });
  // await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  Bloc.observer = MyBlocObserver();
Widget widget;
  bool? isDark = CacheHelper.getBoolean(key: 'isDark');
   uid = CacheHelper.getData(key: 'uid');

    if(uid != null) {
      widget=socialhomelayout();
    } else {
      widget = Loginscreen();
    }


  runApp( MyApp(
   startWidget: widget,
    isDark:isDark
  ));
}

class MyApp extends StatelessWidget {
  final Widget startWidget;
  final bool? isDark;
  MyApp({Key? key,required this.startWidget,required this.isDark});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => socialcubit()
              ..getuserdata()..getposts()),
    BlocProvider(
          create: (context) => ModeCubit()
            ..changeAppMode(
              fromShared: isDark,
            ),)

      ],
        child: BlocConsumer<ModeCubit, ModeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            // theme: lightTheme,
            // darkTheme: darkTheme,
            //  themeMode:ThemeMode.light,
             // ModeCubit
            //     .get(context)
            //     .isDark
            //     ? ThemeMode.dark
            //     : ThemeMode.light,
            debugShowCheckedModeBanner: false,
            home: socialhomelayout(),
          );
        })
    );
  }
}


import 'package:bloc/bloc.dart';
import 'package:chat_app_firebase/shared/components/constants.dart';
import 'package:chat_app_firebase/shared/cubit/bloc_observer.dart';
import 'package:chat_app_firebase/shared/network/local/cache_helper.dart';
import 'package:chat_app_firebase/src/app_root.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'layout/chat_home_layout.dart';
import 'modules/login/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = MyBlocObserver();
  //في حاله cache helper لازم اعمل await ليها عند استدعائها
  await CacheHelper.init();
  Widget widget;
  uId = CacheHelper.getData(key: 'uId') ?? '';
  print(uId);
  if (uId.isNotEmpty) {
    widget = ChatHomeLayout();
  } else {
    widget = const ChatLoginScreen();
  }
  runApp(
      AppRoot(
    startWidget: widget,
  ));
}

import 'package:chat_app_firebase/shared/function/function.dart';
import 'package:chat_app_firebase/shared/styles/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../modules/login/login_screen.dart';
import '../shared/components/constants.dart';
import '../shared/cubit/chat_app_cubit.dart';
import '../shared/cubit/chat_app_state.dart';
import '../shared/network/local/cache_helper.dart';

// ignore: must_be_immutable
class ChatHomeLayout extends StatelessWidget {
  Color inActiveColor = Colors.grey[700]!;
  Color activeColor = baseColor;
  double iconSize = 30.0;

  ChatHomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatAppCubit, ChatAppState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = ChatAppCubit.get(context);
        return Scaffold(
            appBar: AppBar(
              title: cubit.appBar[cubit.currentIndex],
              actions: [
                Container(
                  height: 40.0,
                  width: 40.0,
                  margin: EdgeInsets.only(right: 10.0),
                  decoration: BoxDecoration(
                    color: baseColor,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.notifications_outlined,
                        color: Colors.white,
                      )),
                ),
                Container(
                  height: 40.0,
                  width: 40.0,
                  margin: EdgeInsets.only(right: 5.0),
                  decoration:
                      BoxDecoration(color: baseColor, shape: BoxShape.circle),
                  child: IconButton(
                    onPressed: () {
                      showPopup(
                          context: context,
                          title: Image.asset(
                            'images/illustration-exit-door.png',
                            width: 150.0,
                            height: 150.0,
                          ),
                          text: 'Are you sure',
                        action: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              MaterialButton(
                                color: baseColor,
                                child: Text('Cancel',style: TextStyle(
                                    color: Colors.white
                                ),),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              SizedBox(
                                width: 50.0,
                              ),
                              MaterialButton(
                                color: baseColor,
                                child: Text('Logout',style: TextStyle(
                                    color: Colors.white
                                ),),
                                onPressed: () {
                                  FirebaseAuth.instance.signOut().then((value) {
                                    CacheHelper.removeData(key: uId).then((value) {
                                      navigateTo(context, ChatLoginScreen(), true);
                                    });
                                  });
                                },
                              ),
                            ],
                          ),
                        ]
                      );
                    },
                    icon: Icon(
                      Icons.logout_rounded,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: cubit.currentIndex,
              selectedItemColor: Colors.blue,
              onTap: (index) {
                cubit.changeBottomNavBar(index);
              },
              items: [
                BottomNavigationBarItem(
                  icon: Image.asset(
                    height: iconSize,
                    width: iconSize,
                    'images/home.png',
                    color: inActiveColor,
                  ),
                  activeIcon: Image.asset(
                    height: iconSize,
                    width: iconSize,
                    'images/home.png',
                    color: activeColor,
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                    icon: Image.asset(
                      height: iconSize,
                      width: iconSize,
                      'images/chat.png',
                      color: inActiveColor,
                    ),
                    activeIcon: Image.asset(
                      height: iconSize,
                      width: iconSize,
                      'images/chat.png',
                      color: activeColor,
                    ),
                    label: 'Chats'),
                BottomNavigationBarItem(
                    icon: Image.asset(
                      height: iconSize,
                      width: iconSize,
                      'images/settings.png',
                      color: inActiveColor,
                    ),
                    activeIcon: Image.asset(
                      height: iconSize,
                      width: iconSize,
                      'images/settings.png',
                      color: activeColor,
                    ),
                    label: 'Settings'),
              ],
            ),
            body: cubit.screens[cubit.currentIndex]);
      },
    );
  }
}

1. اما بمسح التطبيق وبنزله من الاول واجي اسجل الداتا مبتجيش
2. لو عملت update لل profile بتاعي الداتا مبتجيش في posts  
3. حاحه تانيه مفيش real time posts بمعني لو انا عملت post جديد مش هيظهر في ساعتها
4. و Shimmer الي انا عامله مش راضي يشتغل كويس




مش شغال معايا  persisted bottom nav bar لما اضغط علي app post الدنيا بتبوظ
import 'package:chat_app_firebase/shared/function/function.dart';
import 'package:chat_app_firebase/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import '../modules/5.add_new_post_screen.dart';
import '../shared/cubit/chat_app_cubit.dart';
import '../shared/cubit/chat_app_state.dart';

// ignore: must_be_immutable
class ChatHomeLayout extends StatelessWidget {
Color inActiveColor = Colors.grey[700]!;
Color activeColor = baseColor;
double iconSize = 30.0;
PersistentTabController controller = PersistentTabController(initialIndex: 0);

List<PersistentBottomNavBarItem> navBarsItems() {
return [
PersistentBottomNavBarItem(
icon: Icon(Icons.home),
title: ("Home"),
activeColorPrimary: Colors.blue,
inactiveColorPrimary: Colors.grey,
),
PersistentBottomNavBarItem(
icon: Icon(Icons.chat_rounded),
title: ("Chats"),
activeColorPrimary: Colors.blue,
inactiveColorPrimary: Colors.grey,
),
PersistentBottomNavBarItem(
icon: Icon(Icons.post_add),
title: ("Add Post"),
activeColorPrimary: Colors.blue,
inactiveColorPrimary: Colors.grey,
),
PersistentBottomNavBarItem(
icon: Icon(Icons.supervised_user_circle_outlined),
title: ("Users"),
activeColorPrimary: Colors.blue,
inactiveColorPrimary: Colors.grey,
),
PersistentBottomNavBarItem(
icon: Icon(Icons.settings),
title: ("Settings"),
activeColorPrimary: Colors.blue,
inactiveColorPrimary: Colors.grey,
),
];
}

ChatHomeLayout({super.key});

@override
Widget build(BuildContext context) {
return BlocConsumer<ChatAppCubit, ChatAppState>(
listener: (context, state) {
// TODO: implement listener
if (state is AddNewPostState) {
navigateTo(context, AddNewPost(), false);
}
},
builder: (context, state) {
var cubit = ChatAppCubit.get(context);
return Scaffold(
appBar: AppBar(
title: Text(
cubit.appBar[cubit.currentIndex],
),
actions: [
IconButton(
onPressed: () {},
icon: Image.asset(
'images/notification.png',
height: 25.0,
),
),
IconButton(
onPressed: () {},
icon: Image.asset('images/glass.png'),
),
],
),
body: PersistentTabView(
context,
screens: cubit.buildScreens(),
items: navBarsItems(),
backgroundColor: Colors.white,
onItemSelected: (index) {
cubit.changeBottomNavBar(index);
},
handleAndroidBackButtonPress: true,
resizeToAvoidBottomInset: true,
stateManagement: true,
decoration: NavBarDecoration(
borderRadius: BorderRadius.circular(10.0),
colorBehindNavBar: Colors.white,
),
navBarStyle: NavBarStyle
.style3, // Choose the nav bar style with this property.
),
);
},
);
}
}


color: Colors.transparent,
backgroundColor: baseColor,
height: 300.0,
animSpeedFactor: 2,
onRefresh: () async {
cubit.getPosts();
cubit.getAllUsers();
cubit.getUserdata();
return await Future.delayed(Duration(seconds: 1));
},


//tages
// Container(
//   margin: const EdgeInsets.symmetric(vertical: 10.0),
//   width: double.infinity,
//   child: Wrap(
//     children: [
//       Container(
//         margin: const EdgeInsets.only(right: 5.0),
//         height: 25.0,
//         child: MaterialButton(
//           padding: EdgeInsets.zero,
//           onPressed: () {},
//           minWidth: 1.0,
//           child: const Text(
//             '#software',
//             style: TextStyle(color: Colors.blue),
//           ),
//         ),
//       ),
//       Container(
//         margin: const EdgeInsets.only(right: 5.0),
//         height: 25.0,
//         child: MaterialButton(
//           padding: EdgeInsets.zero,
//           onPressed: () {},
//           minWidth: 1.0,
//           child: const Text(
//             '#flutter',
//             style: TextStyle(color: Colors.blue),
//           ),
//         ),
//       ),
//       Container(
//         margin: const EdgeInsets.only(right: 5.0),
//         height: 25.0,
//         child: MaterialButton(
//           padding: EdgeInsets.zero,
//           onPressed: () {},
//           minWidth: 1.0,
//           child: const Text(
//             '#software_development',
//             style: TextStyle(color: Colors.blue),
//           ),
//         ),
//       ),
//     ],
//   ),
// ),
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../shared/cubit/chat_app_cubit.dart';
import '../shared/styles/colors.dart';

class AppRoot extends StatelessWidget {
  final Widget? startWidget;

  const AppRoot({super.key, this.startWidget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => ChatAppCubit()
              ..getUserdata()
              ..getStory()
              ..getPosts()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(
            toolbarHeight: 65.0,
            color: Colors.white,
            systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Colors.black,
                statusBarIconBrightness: Brightness.light,
                systemNavigationBarColor: Colors.black),
            elevation: 0.0,
            titleTextStyle: TextStyle(
                fontWeight: FontWeight.bold, color: baseColor, fontSize: 25.0),
            //backgroundColor: Colors.white,
          ),
        ),
        debugShowCheckedModeBanner: false,
        home: startWidget,
      ),
    );
  }
}

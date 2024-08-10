import 'package:chat_app_firebase/shared/cubit/chat_app_cubit.dart';
import 'package:chat_app_firebase/shared/cubit/chat_app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../styles/colors.dart';

// ignore: must_be_immutable
class BuildMyStory extends StatelessWidget {
  final void Function() onTap;

  const BuildMyStory({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatAppCubit, ChatAppState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var userModel = ChatAppCubit.get(context).userModel;
        //
        // if (userModel == null) {
        //   return CircularProgressIndicator();
        // }
        return InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(15.0),
          radius: 0.0,
          child: Container(
            
              height: 210.0,
              width: 130.0,
              decoration: BoxDecoration(
                  color: Color(0xfff7f2f9),
                  borderRadius: BorderRadius.circular(15.0),
                border: Border.all(
                    color:Colors.black.withOpacity(0.04)
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 165.0,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        if (userModel != null)
                        Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            height: 150.0,
                            child: Container(
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              decoration: BoxDecoration(
                                  color: Color(0xffeaddff),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                        '${ChatAppCubit.get(context).userModel!.image}'),
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadiusDirectional.only(
                                      topStart: Radius.circular(15.0),
                                      topEnd: Radius.circular(15.0))),
                            ),
                          ),
                        ),
                        CircleAvatar(
                          backgroundColor: Color(0xffeaddff),
                          radius: 20.0,
                          child: CircleAvatar(
                            backgroundColor: baseColor,
                            radius: 18.0,
                            child: Icon(
                              Icons.add,
                              size: 25.0,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Text(
                      'Create Story',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 15.0),
                    ),
                  ),
                ],
              )),
        );
      },
    );
  }
}

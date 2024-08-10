import 'package:chat_app_firebase/modules/screens/4.add_new_post_screen.dart';
import 'package:chat_app_firebase/shared/cubit/chat_app_cubit.dart';
import 'package:chat_app_firebase/shared/cubit/chat_app_state.dart';
import 'package:chat_app_firebase/shared/function/function.dart';
import 'package:chat_app_firebase/shared/styles/colors.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'build_post_item.dart';

class MyPosts extends StatelessWidget {
  const MyPosts({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatAppCubit, ChatAppState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit=ChatAppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('My Posts'),
            centerTitle: true,
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ConditionalBuilder(
                  condition:  cubit.myPosts.isNotEmpty &&
                      cubit.userModel != null &&
                      state is! ChatGetPostsLoadingState,
                  builder: (context) => Expanded(
                    child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      padding: EdgeInsets.only(left: 10.0,right: 10.0,bottom: 20.0),
                      itemBuilder: (context, index) => BuildPostItem(
                        index: index,
                        model: cubit.myPosts[index],
                      ),
                      separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(
                        height: 10.0,
                      ),
                      itemCount: cubit.myPosts.length,
                    ),
                  ),
                  fallback: (context) => Center(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'No Posts Available',
                                style: TextStyle(
                                    fontSize: 20.0, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 16),
                              Text(
                                'There are no posts available at the moment. If you have any posts to add, please press the button below.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[600]),
                              ),
                              SizedBox(height: 24),
                              MaterialButton(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 10.0),
                                color: baseColor,
                                onPressed: () {
                                  navigateTo(context, AddNewPost(), false);
                                },
                                child: Text(
                                  'Add a New Post',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
            ],
          ),
        );
      },
    );
  }
}

import 'package:chat_app_firebase/models/post_model.dart';
import 'package:chat_app_firebase/shared/cubit/chat_app_cubit.dart';
import 'package:chat_app_firebase/shared/cubit/chat_app_state.dart';
import 'package:chat_app_firebase/shared/styles/colors.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../function/function.dart';

class BuildPostItem extends StatelessWidget {
  final PostModel model;
  final int index;

  const BuildPostItem({super.key, required this.model, required this.index});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatAppCubit, ChatAppState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = ChatAppCubit.get(context);
        return Card(
          margin: EdgeInsets.zero,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 30.0,
                      backgroundImage: NetworkImage('${model.image}'),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  '${model.name}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0),
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Icon(
                                  Icons.check_circle,
                                  size: 18.0,
                                  color: Colors.blue,
                                )
                              ],
                            ),
                            Text(
                              '${model.date}',
                              style: TextStyle(
                                  color: Colors.grey[700],
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Image.asset(
                        'images/option.png',
                        height: 22.0,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        // cubit.deletePost(postId: cubit.postId[index]);
                      },
                      icon: Icon(Icons.close),
                    )
                  ],
                ),
                const Divider(
                  height: 30.0,
                ),
                Text(
                  '${model.text}',
                  style: TextStyle(
                      height: 1.2, fontWeight: FontWeight.bold, fontSize: 16.0),
                ),
                if (model.postImage != '')
                  Container(
                      margin: EdgeInsets.only(top: 10.0),
                      height: 160.0,
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: Colors.black.withOpacity(0.1)),
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            // Shadow color
                            spreadRadius: 1,
                            // Spread radius
                            blurRadius: 3,
                            // Blur radius
                            offset: const Offset(
                                0, 7), // Offset in the x, y direction
                          ),
                        ],
                      ),
                      width: double.infinity,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Image(
                          image: NetworkImage('${model.postImage}'),
                          fit: BoxFit.cover,
                        ),
                      )),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            const Icon(
                              CupertinoIcons.heart,
                              color: Colors.red,
                              size: 19.0,
                            ),
                            const SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              //'${cubit.likePostsNo.isNotEmpty ? cubit.likePostsNo[index] : 0}',
                              '0',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[600]),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                            onTap: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const Icon(
                                  Icons.message_outlined,
                                  color: Colors.amber,
                                  size: 19.0,
                                ),
                                const SizedBox(
                                  width: 5.0,
                                ),
                                Text(
                                  '0 comment',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey[600]),
                                )
                              ],
                            )),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 20.0,
                              backgroundImage:
                                  NetworkImage('${cubit.userModel!.image}'),
                            ),
                            const SizedBox(
                              width: 15.0,
                            ),
                            Text(
                              'write a comment ...',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[600]),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                        onTap: () {
                         // cubit.likePosts(postId: cubit.postId[index]);
                        },
                        child: Row(
                          children: [
                            const Icon(
                              CupertinoIcons.heart,
                              color: Colors.red,
                              size: 19.0,
                            ),
                            const SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              'Like',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[600]),
                            )
                          ],
                        ))
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

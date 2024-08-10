import 'package:chat_app_firebase/shared/cubit/chat_app_cubit.dart';
import 'package:chat_app_firebase/shared/cubit/chat_app_state.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../shared/function/function.dart';
import '../../shared/styles/colors.dart';

// ignore: must_be_immutable
class AddNewPost extends StatelessWidget {
  AddNewPost({super.key});

  var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatAppCubit, ChatAppState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is CreatePostSuccessState) {
          snakeBar(
              context: context,
              text: 'Post Added successful!',
              color: Colors.green);
          //navigateTo(context, ChatHomeLayout(), true);
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        var cubit = ChatAppCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Create Post',
              style: TextStyle(
                color: baseColor
              ),
            ),
            actions: [
              ConditionalBuilder(
                  condition: state is! CreatePostLoadingState &&
                      state is! UploadPostImageLoadingState,
                  builder: (context) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: MaterialButton(
                          color: baseColor,
                          onPressed: () {
                            var now = DateTime.now();
                            String formattedTime =
                                DateFormat('yyyy-MM-dd – kk:mm').format(now);
                            if (cubit.postImage == null) {
                              cubit.createPost(
                                text: textController.text,
                                date: formattedTime,
                              );
                            } else {
                              cubit.uploadPostImage(
                                  text: textController.text,
                                  date: formattedTime);
                            }
                          },
                          child: Text(
                            'Post',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                  fallback: (context) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: CircularProgressIndicator(
                          color: baseColor,
                        ),
                      ))
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 30.0,
                      backgroundImage:
                          NetworkImage('${cubit.userModel!.image}'),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                '${cubit.userModel!.name}',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0),
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                            ],
                          ),
                          Text(
                            'Public',
                            style: TextStyle(
                                color: Colors.grey[700],
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'What is on your mind ?',
                        hintStyle: TextStyle(fontSize: 14.0)),
                  ),
                ),
                if (cubit.postImage != null)
                  Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Container(
                          margin: const EdgeInsets.all(10.0),
                          height: 180.0,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.black.withOpacity(0.1)),
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                // Shadow color
                                spreadRadius: 3,
                                // Spread radius
                                blurRadius: 7,
                                // Blur radius
                                offset: const Offset(
                                    0, 8), // Offset in the x, y direction
                              ),
                            ],
                          ),
                          width: double.infinity,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: Image(
                              image: FileImage(cubit.postImage!),
                              fit: BoxFit.cover,
                            ),
                          )),
                      IconButton(
                        padding: EdgeInsetsDirectional.all(20.0),
                        onPressed: () {
                          cubit.removePostImage();
                        },
                        icon: CircleAvatar(
                          radius: 17.0,
                          backgroundColor: baseColor,
                          child: Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 20.0,
                          ),
                        ),
                      )
                    ],
                  ),
                Row(
                  children: [
                    Expanded(
                      child: MaterialButton(
                        onPressed: () {
                          cubit.getPostImage();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add_a_photo_outlined,
                              color: baseColor,
                              size: 18.0,
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              'add photos',
                              style: TextStyle(color: baseColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      child: MaterialButton(
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.tag_outlined,
                              color: baseColor,
                              size: 18.0,
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              'tags',
                              style: TextStyle(color: baseColor),
                            ),
                          ],
                        ),
                      ),
                    ),
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

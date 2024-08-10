import 'package:chat_app_firebase/models/user_model.dart';
import 'package:chat_app_firebase/shared/cubit/chat_app_cubit.dart';
import 'package:chat_app_firebase/shared/cubit/chat_app_state.dart';
import 'package:chat_app_firebase/shared/styles/colors.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'build_receiver_message.dart';
import 'build_sender_message.dart';

// ignore: must_be_immutable
class ChatScreenDetails extends StatelessWidget {
  final UserModel model;
  var textController = TextEditingController();
  var focusNode = FocusNode();
  var formKey = GlobalKey<FormState>();

  ChatScreenDetails({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        ChatAppCubit.get(context).getMessage(
          receiverId: model.uId!,
        );
        return BlocConsumer<ChatAppCubit, ChatAppState>(
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            var cubit = ChatAppCubit.get(context);
            return Scaffold(
              appBar: AppBar(
                titleSpacing: 0.0,
                toolbarHeight: 70.0,
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 25.0,
                      backgroundImage: NetworkImage('${model.image}'),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        children: [
                          Text(
                            '${model.name}',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 14.0),
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
                    ),
                  ],
                ),
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.phone),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.video_call),
                  ),
                ],
              ),
              body: Form(
                key: formKey,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                            'images/WhatsApp Image 2024-07-10 at 17.26.47_9355600b.jpg',
                          ),
                          fit: BoxFit.cover)),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                  'images/WhatsApp Image 2024-07-10 at 17.26.47_9355600b.jpg'))),
                      child: Column(
                        children: [
                          Expanded(
                            child: ConditionalBuilder(
                              condition: cubit.messages.length > 0,
                              builder: (context) {
                                return ListView.builder(
                                  itemBuilder: (context, index) {
                                    if (cubit.userModel!.uId ==
                                        cubit.messages[index].receiverId) {
                                      return BuildReceiverMessage(
                                        model: cubit.messages[index],
                                      );
                                    }
                                    return BuildSenderMessage(
                                      model: cubit.messages[index],
                                    );
                                  },
                                  itemCount: cubit.messages.length,
                                );
                              },
                              fallback: (context) => Center(child: Text('')),
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadiusDirectional.circular(
                                              20.0)),
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'No message found! Please write something';
                                      }
                                      return null;
                                    },
                                    focusNode: focusNode,
                                    cursorColor: baseColor,
                                    controller: textController,
                                    decoration: InputDecoration(
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          cubit.getMessageImage();
                                        },
                                        icon: Icon(
                                          Icons.attach_file_outlined,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      hintText: 'type your message here.....',
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          borderSide: BorderSide.none),
                                      focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          borderSide: BorderSide.none),
                                    ),
                                    onChanged: (value) {
                                      // cubit.isButtonClicked();
                                    },
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              Container(
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      shape: BoxShape.circle),
                                  child: IconButton(
                                      onPressed: () {
                                        var now = DateTime.now();
                                        String formattedTime =
                                            DateFormat('kk:mm').format(now);
                                        if (cubit.isClicked == false) {
                                          if (formKey.currentState!
                                              .validate()) {
                                            cubit.sendMessage(
                                                receiverId: model.uId!,
                                                messageDate: formattedTime,
                                                messageText:
                                                    textController.text);
                                            textController.clear();
                                            focusNode.unfocus();
                                          }
                                        } else {
                                          print('voice');
                                        }
                                      },
                                      icon: cubit.isClicked == false
                                          ? Icon(
                                              Icons.send,
                                              color: Colors.white,
                                            )
                                          : Icon(
                                              Icons.keyboard_voice,
                                              color: Colors.white,
                                            )))
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

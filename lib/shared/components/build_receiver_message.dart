import 'package:chat_app_firebase/shared/cubit/chat_app_cubit.dart';
import 'package:chat_app_firebase/shared/cubit/chat_app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/message_model.dart';

// ignore: must_be_immutable
class BuildReceiverMessage extends StatelessWidget {
  final MessageModel model;

  BuildReceiverMessage({super.key, required this.model});

  double borderRadius = 20.0;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatAppCubit, ChatAppState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = ChatAppCubit.get(context);
        return Align(
          alignment: Alignment.bottomLeft,
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 10.0),
                padding: EdgeInsets.only(
                    right: 20.0, left: 90.0, top: 10.0, bottom: 10.0),
                decoration: BoxDecoration(
                    color: Color(0xff1d2a31),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(borderRadius),
                      topLeft: Radius.circular(borderRadius),
                      bottomRight: Radius.circular(borderRadius),
                    )),
                child: Text(
                  '${model.messageText}',
                  style: TextStyle(
                      fontSize: 17.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 12.0, bottom: 12.0, left: 12.0, right: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.done_all,
                      color: Colors.green,
                      size: 20.0,
                    ),
                    SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      '${model.messageDate}',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

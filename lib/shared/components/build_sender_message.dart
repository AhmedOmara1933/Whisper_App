import 'package:chat_app_firebase/shared/cubit/chat_app_cubit.dart';
import 'package:chat_app_firebase/shared/cubit/chat_app_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/message_model.dart';

// ignore: must_be_immutable
class BuildSenderMessage extends StatelessWidget {
  final MessageModel model;

  BuildSenderMessage({super.key, required this.model});

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
          alignment: Alignment.bottomRight,
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 10.0),
                padding: EdgeInsets.only(left: 20.0,right: 90.0, top: 10.0,bottom: 10.0),
                decoration: BoxDecoration(
                    color: Color(0xff134d37),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(borderRadius),
                      topLeft: Radius.circular(borderRadius),
                      bottomLeft: Radius.circular(borderRadius),
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
                padding: const EdgeInsets.only(top: 12.0,bottom: 12.0,left: 12.0,right: 5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('${model.messageDate}',style: TextStyle(
                      color: Colors.grey[600]
                    ),),
                    SizedBox(width: 5.0,),
                    Icon(Icons.done_all,color: Colors.green,size: 20.0,)
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

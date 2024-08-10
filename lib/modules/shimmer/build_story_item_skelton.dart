import 'package:chat_app_firebase/models/story_model.dart';
import 'package:chat_app_firebase/modules/shimmer/skelton.dart';
import 'package:flutter/material.dart';

class BuildStoryItemSkelton extends StatelessWidget {
  final StoryModel ?model;
  const BuildStoryItemSkelton({super.key, this.model});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(left: 10.0),
            height: 210.0,
            width: 130.0,
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.09),
                borderRadius: BorderRadius.circular(15.0)),
            ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0,vertical: 10.0),
          child: Skelton(
            isCircle: true,
            height: 65.0,
            width: 65.0,
          ),
        )
      ],
    );
  }
}

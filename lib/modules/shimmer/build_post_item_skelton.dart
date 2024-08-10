import 'package:chat_app_firebase/models/post_model.dart';
import 'package:chat_app_firebase/modules/shimmer/skelton.dart';
import 'package:flutter/material.dart';

class BuildPostItemSkelton extends StatelessWidget {
  final PostModel model;

  const BuildPostItemSkelton({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.black.withOpacity(0.04),
          border: Border.all(
            color: Colors.black.withOpacity(0.09),
          )),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Skelton(
                      height: 70.0,
                      width: 70.0,
                      isCircle: true,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Skelton(height: 15.0, width: 200),
                          Skelton(height: 15.0, width: 250.0),
                        ],
                      ),
                    ),
                  ],
                ),
                Skelton(height: 15.0, width: double.infinity),
                Skelton(height: 15.0, width: double.infinity),
                Skelton(height: 15.0, width: 300),
                if(model.postImage != '')
                Skelton(height: 150.0, width: double.infinity),
                Row(
                  children: [
                    Expanded(
                      child: Skelton(height: 30.0),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      child: Skelton(height: 30.0),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Skelton(
                      isCircle: true,
                      height: 50.0,
                      width: 50.0,
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Expanded(
                      child: Skelton(
                        height: 20.0,
                      ),
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Skelton(
                      height: 20.0,
                      width: 90.0,
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

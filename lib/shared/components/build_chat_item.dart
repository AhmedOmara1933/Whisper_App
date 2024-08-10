import 'package:chat_app_firebase/shared/function/function.dart';
import 'package:flutter/material.dart';
import '../../models/user_model.dart';
import 'chat_screen_details.dart';

class BuildChatItem extends StatelessWidget {
  final UserModel model;

  const BuildChatItem({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: InkWell(
        onTap: () {
          navigateTo(context, ChatScreenDetails(model: model), false);
        },
        radius: 40.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 30.0,
                      backgroundImage: NetworkImage('${model.image}'),
                    ),
                    CircleAvatar(
                      radius: 9.0,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 6.0,
                        backgroundColor: Colors.green,
                      ),
                    )
                  ],
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
                ),
              ],
            ),
            IconButton(
              onPressed: () {},
              icon: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.chat_outlined,
                    color: Colors.grey[700],
                  )),
            )
          ],
        ),
      ),
    );
  }
}

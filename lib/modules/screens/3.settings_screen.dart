import 'package:chat_app_firebase/modules/shimmer/skelton.dart';
import 'package:chat_app_firebase/shared/components/my_own_posts.dart';
import 'package:chat_app_firebase/shared/cubit/chat_app_state.dart';
import 'package:chat_app_firebase/shared/function/function.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared/components/edit_profile_screen.dart';
import '../../shared/cubit/chat_app_cubit.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatAppCubit, ChatAppState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var userModel = ChatAppCubit.get(context).userModel;
        var cubit = ChatAppCubit.get(context);
        return SingleChildScrollView(
          child: ConditionalBuilder(
            condition: userModel != null,
            builder: (context) => Column(
              children: [
                SizedBox(
                  height: 240.0,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
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
                                image: cubit.coverImage == null
                                    ? NetworkImage('${userModel!.cover}')
                                    : FileImage(cubit.coverImage!)
                                        as ImageProvider<Object>,
                                fit: BoxFit.cover,
                              ),
                            )),
                      ),
                      CircleAvatar(
                          radius: 60.0,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 55.0,
                            backgroundImage: cubit.profileImage == null
                                ? NetworkImage('${userModel!.image}')
                                : FileImage(cubit.profileImage!)
                                    as ImageProvider<Object>,
                          )),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Text(
                  '${userModel!.name}',
                  style: TextStyle(fontSize: 23.0, fontWeight: FontWeight.bold),
                ),
                Text(
                  '${userModel.bio}',
                  style: TextStyle(fontSize: 15.0, color: Colors.grey[600]),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 20.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {},
                          child: const Column(
                            children: [
                              Text(
                                '100',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0),
                              ),
                              Text('Posts'),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {},
                          child: const Column(
                            children: [
                              Text(
                                '265',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0),
                              ),
                              Text('Photos'),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {},
                          child: const Column(
                            children: [
                              Text(
                                '10k',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0),
                              ),
                              Text('Followers'),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {},
                          child: const Column(
                            children: [
                              Text(
                                '64',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0),
                              ),
                              Text('Following'),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: MaterialButton(
                            padding: const EdgeInsets.symmetric(vertical: 15.0),
                            color: Colors.blue,
                            onPressed: () {
                              navigateTo(context, MyPosts(), false);
                            },
                            child: const Text(
                              'My Posts',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 16.0),
                            )),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      MaterialButton(
                          padding: const EdgeInsets.symmetric(vertical: 12.0),
                          color: Colors.blue,
                          onPressed: () {
                            navigateTo(context, EditProfileScreen(), false);
                          },
                          child: Image.asset(
                            'images/pencil.png',
                            height: 30.0,
                            color: Colors.white,
                          ))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 15.0),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Number of columns
                      crossAxisSpacing: 10.0, // Spacing between columns
                      mainAxisSpacing: 10.0, // Spacing between rows
                    ),
                    itemCount: cubit.myPostImages.length,
                    itemBuilder: (context, index) {
                      return Container(
                          decoration: BoxDecoration(
                              color: Color(0xffeaddff),
                              borderRadius: BorderRadius.circular(20.0)),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: GridTile(
                              child: Image.network(
                            '${cubit.myPostImages[index]}',
                            fit: BoxFit.cover,
                          )));
                    },
                  ),
                ),
              ],
            ),
            fallback: (context) => Column(
              children: [
                SizedBox(
                  height: 240.0,
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          margin: const EdgeInsets.all(10.0),
                          height: 180.0,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.04),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          width: double.infinity,
                        ),
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 65.0,
                        child: CircleAvatar(
                          radius: 60.0,
                          backgroundColor: Colors.black.withOpacity(0.04),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Skelton(
                  width: 200.0,
                  height: 30.0,
                ),
                Skelton(
                  width: 300,
                  height: 30.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Skelton(
                          height: 50.0,
                          width: 50.0,
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: Skelton(
                          height: 50.0,
                          width: 50.0,
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: Skelton(
                          height: 50.0,
                          width: 50.0,
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: Skelton(
                          height: 50.0,
                          width: 50.0,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Skelton(
                          height: 60.0,
                        )
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Skelton(
                        height: 60.0,
                        width: 70.0,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 15.0),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Number of columns
                      crossAxisSpacing: 10.0, // Spacing between columns
                      mainAxisSpacing: 10.0, // Spacing between rows
                    ),
                    itemCount: 2,
                    itemBuilder: (context, index) {
                      return Skelton(
                        height: 80.0,
                        width: 80.0,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

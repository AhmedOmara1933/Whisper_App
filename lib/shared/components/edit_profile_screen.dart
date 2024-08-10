import 'package:chat_app_firebase/shared/components/textFormField.dart';
import 'package:chat_app_firebase/shared/cubit/chat_app_cubit.dart';
import 'package:chat_app_firebase/shared/cubit/chat_app_state.dart';
import 'package:chat_app_firebase/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../function/function.dart';

// ignore: must_be_immutable
class EditProfileScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var bioController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatAppCubit, ChatAppState>(
      listener: (context, state) {
        // TODO: implement listener
        if (state is ChatUpdateUserLoadingState) {
          snakeBar(
              text: 'Data updated successfully!',
              color: Colors.green,
              context: context);
        }
      },
      builder: (context, state) {
        var cubit = ChatAppCubit.get(context);
        var userModel = cubit.userModel;
        bioController.text = userModel!.bio!;
        nameController.text = userModel.name!;
        phoneController.text = userModel.phone!;
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Edit Profile',
            ),
            actions: [
              if (cubit.profileImage == null && cubit.coverImage == null)
                Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: MaterialButton(
                  color: baseColor,
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      cubit.updateUserData(
                          name: nameController.text,
                          phone: phoneController.text,
                          bio: bioController.text);
                    }
                  },
                  child: Text(
                    'Update',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  SizedBox(
                    height: 240.0,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Stack(
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
                                        offset: const Offset(0,
                                            8), // Offset in the x, y direction
                                      ),
                                    ],
                                  ),
                                  width: double.infinity,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    child: Image(
                                      image: cubit.coverImage == null
                                          ? NetworkImage('${userModel.cover}')
                                          : FileImage(cubit.coverImage!)
                                              as ImageProvider<Object>,
                                      fit: BoxFit.cover,
                                    ),
                                  )),
                              IconButton(
                                padding: EdgeInsetsDirectional.all(20.0),
                                onPressed: () {
                                  cubit.getCoverImage();
                                },
                                icon: CircleAvatar(
                                  radius: 17.0,
                                  backgroundColor: baseColor,
                                  child: Icon(
                                    Icons.camera_alt_outlined,
                                    color: Colors.white,
                                    size: 20.0,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            CircleAvatar(
                              radius: 60.0,
                              backgroundColor: Colors.white,
                              child: CircleAvatar(
                                radius: 55.0,
                                backgroundImage: cubit.profileImage == null
                                    ? NetworkImage('${userModel.image}')
                                    : FileImage(cubit.profileImage!)
                                        as ImageProvider<Object>,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                cubit.getProfileImage();
                              },
                              icon: CircleAvatar(
                                radius: 17.0,
                                backgroundColor: baseColor,
                                child: Icon(
                                  Icons.camera_alt_outlined,
                                  color: Colors.white,
                                  size: 20.0,
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  if (cubit.profileImage != null || cubit.coverImage != null)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        children: [
                          if (cubit.profileImage != null)
                            // if(state is ChatGetUserSuccessState)
                            //   Icon(Icons.done_all)
                            // else
                            Expanded(
                              child: Column(
                                children: [
                                  Container(
                                    width: double.infinity,
                                    child: MaterialButton(
                                      color: baseColor,
                                      onPressed: () {
                                        cubit.uploadProfileImage(
                                            name: nameController.text,
                                            phone: phoneController.text,
                                            bio: bioController.text);
                                      },
                                      child: Text(
                                        'upload profile',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  if (state is ChatUploadProfileLoadingState)
                                    LinearProgressIndicator(
                                      color: baseColor,
                                    )
                                ],
                              ),
                            ),
                          SizedBox(
                            width: 10.0,
                          ),
                          if (cubit.coverImage != null)
                            Expanded(
                              child: Column(
                                children: [
                                  Container(
                                    width: double.infinity,
                                    child: MaterialButton(
                                      color: baseColor,
                                      onPressed: () {
                                        cubit.uploadCoverImage(
                                            name: nameController.text,
                                            phone: phoneController.text,
                                            bio: bioController.text);
                                      },
                                      child: Text(
                                        'upload cover',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  if (state is ChatUploadCoverLoadingState)
                                    LinearProgressIndicator(
                                      color: baseColor,
                                    )
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: DefaultTextFormField(
                      controller: nameController,
                      keyboardType: TextInputType.name,
                      hintText: 'Name',
                      prefixIcon: Icon(Icons.people_alt_outlined),
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'name must be filled';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: DefaultTextFormField(
                      controller: bioController,
                      keyboardType: TextInputType.name,
                      hintText: 'Bio',
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'name must be filled';
                        }
                        return null;
                      },
                      prefixIcon: Icon(Icons.view_headline_outlined),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: DefaultTextFormField(
                      hintText: 'Phone',
                      validate: (value) {
                        if (value!.isEmpty) {
                          return 'name must be filled';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.phone,
                      controller: phoneController,
                      //contentPadding: true,
                      prefixIcon: Icon(Icons.phone),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

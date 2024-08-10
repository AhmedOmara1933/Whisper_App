import 'package:chat_app_firebase/models/message_model.dart';
import 'package:chat_app_firebase/models/post_model.dart';
import 'package:chat_app_firebase/models/story_model.dart';
import 'package:chat_app_firebase/shared/components/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../models/user_model.dart';
import '../../modules/screens/1.home_screen.dart';
import '../../modules/screens/2.chats_screen.dart';
import '../../modules/screens/3.settings_screen.dart';
import 'chat_app_state.dart';
import 'dart:io';

class ChatAppCubit extends Cubit<ChatAppState> {
  ChatAppCubit() : super(ChatAppInitial());

  static ChatAppCubit get(context) => BlocProvider.of(context);
  List screens = [
    const HomeScreen(),
    const ChatsScreen(),
    const SettingsScreen()
  ];
  List<Widget> appBar = [
    Row(
      children: [
        Image.asset(
          'images/messaging.png',
          height: 40.0,
          width: 40.0,
        ),
        SizedBox(
          width: 10.0,
        ),
        Text(
          'Whisper',
        ),
      ],
    ),
    Text(
      'Chats',
    ),
    Text(
      'Settings',
    )
  ];
  int currentIndex = 0;
  UserModel? userModel;
  final imagePicker = ImagePicker();
  File? profileImage;
  File? coverImage;
  File? postImage;
  File? messageImage;
  File? storyImage;
  List<PostModel> posts = [];
  List<PostModel> myPosts = [];
  List<UserModel> users = [];
  List<StoryModel> stories = [];
  List<MessageModel> messages = [];
  List<String> postId = [];
  List<int> likePostsNo = [];
  List<String> myPostImages = [];
  bool isClicked = false;

//todo////////////////////////////////changeBottomNavBar///////////////////////////
  void changeBottomNavBar(int index) {
    if (index == 1) {
      getAllUsers();
    }
    currentIndex = index;
    emit(ChangeBottomNavBarState());
  }

//todo////////////////////////////////getUserdata///////////////////////////
  void getUserdata() {
    emit(ChatGetUserLoadingState());
    //تظبيط الشغل
    if (uId != null && uId.isNotEmpty)
      FirebaseFirestore.instance
          .collection('users')
          .doc(uId)
          .get()
          .then((value) {
        userModel = UserModel.fromJson(value.data()!);
        // print(value.data());
        emit(ChatGetUserSuccessState());
      }).catchError((error) {
        emit(ChatGetUserErrorState(error: error.toString()));
        print('the error is $error');
      });
  }

//todo////////////////////////////////ProfileImage///////////////////////////

  getProfileImage() async {
    await imagePicker.pickImage(source: ImageSource.gallery).then((value) {
      if (value != null) {
        profileImage = File(value.path);
        emit(GetProfileImageSuccessState());
        print(profileImage);
        print(Uri.file(profileImage!.path).pathSegments.last);
      } else {
        emit(GetProfileImageCanceledState());
      }
    }).catchError((error) {
      emit(GetProfileImageErrorState(error: error.toString()));
    });
  }

  uploadProfileImage({
    required String name,
    required String phone,
    required String bio,
    String? image,
  }) {
    emit(ChatUploadProfileLoadingState());
    FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        //  print('then2 : ${value}');
        // profileImageUrl = value;
        // print(profileImageUrl);
        // emit(UploadProfileImageSuccessState());
        updateUserData(name: name, phone: phone, bio: bio, image: value);
      }).catchError((error) {
        emit(UploadProfileImageErrorState(error: error.toString()));
        print(error.toString());
      });
    }).catchError((error) {
      emit(UploadProfileImageErrorState(error: error.toString()));
      print(error.toString());
    });
  }

//todo////////////////////////////////CoverImage///////////////////////////////

  getCoverImage() async {
    await imagePicker.pickImage(source: ImageSource.gallery).then((value) {
      if (value != null) {
        coverImage = File(value.path);
        emit(GetCoverImageSuccessState());
        print(coverImage);
      } else {
        emit(GetCoverImageCanceledState());
      }
    }).catchError((error) {
      emit(GetCoverImageErrorState(error: error.toString()));
    });
  }

  uploadCoverImage({
    required String name,
    required String phone,
    required String bio,
    String? cover,
  }) {
    emit(ChatUploadCoverLoadingState());
    FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        // coverImageUrl = value;
        // print(coverImageUrl);
        //emit(UploadCoverImageSuccessState());
        updateUserData(name: name, phone: phone, bio: bio, cover: value);
      }).catchError((error) {
        emit(UploadCoverImageErrorState(error: error.toString()));
      });
    }).catchError((error) {
      emit(UploadCoverImageErrorState(error: error.toString()));
    });
  }

//todo////////////////////////////////updateUserData///////////////////////////
  void updateUserData({
    required String name,
    required String phone,
    required String bio,
    String? image,
    String? cover,
  }) {
    emit(ChatUpdateUserLoadingState());
    UserModel model = UserModel(
      name: name,
      phone: phone,
      bio: bio,
      email: userModel!.email,
      uId: userModel!.uId,
      cover: cover ?? userModel!.cover,
      image: image ?? userModel!.image,
    );

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .update(model.toMap())
        .then((value) {
      getUserdata();
    }).catchError((error) {
      emit(ChatUpdateUserErrorState());
    });
  }

//todo////////////////////////////////GetPostData////////////////////////////////
  getAllUsers() {
    emit(ChatGetAllUsersLoadingState());
    if (users.length == 0)
      FirebaseFirestore.instance.collection('users').get().then((value) {
        value.docs.forEach((element) {
          if (element.data()['uId'] != userModel!.uId)
            users.add(UserModel.fromJson(element.data()));
          print(users);
        });
        emit(ChatGetAllUsersSuccessState());
      }).catchError((error) {
        emit(ChatGetAllUsersErrorState(error: error.toString()));
        print(error);
      });
  }

//todo////////////////////////////////Send&Get Message////////////////////////////////
  sendMessage(
      {required String receiverId,
      required String messageDate,
      required String messageText,
      String? messageImage}) {
    MessageModel model = MessageModel(
      messageDate: messageDate,
      messageText: messageText,
      receiverId: receiverId,
      senderId: userModel!.uId,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SendMessagesSuccessState());
    }).catchError((error) {
      emit(SendMessagesErrorState(error: error.toString()));
      print(error);
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel!.uId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(ReceiveMessagesSuccessState());
    }).catchError((error) {
      emit(ReceiveMessagesErrorState(error: error.toString()));
    });
  }

  getMessage({
    required String receiverId,
  }) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy('messageDate')
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));
      });
      emit(GetMessageSuccessState());
    });
  }

//todo////////////////////////////////////////////////////////////////
  isButtonClicked() {
    isClicked = !isClicked;
    emit(IsButtonClickedSuccessState());
  }

  getMessageImage() async {
    await imagePicker.pickImage(source: ImageSource.gallery).then((value) {
      if (value != null) {
        messageImage = File(value.path);
        emit(GetMessageImageSuccessState());
        print(messageImage);
      } else {
        emit(GetMessageImageCanceledState());
      }
    }).catchError((error) {
      emit(GetMessageImageErrorState(error: error.toString()));
    });
  }

  // void likePosts({required String postId}) {
  //   emit(LikePostLoadingState());
  //   FirebaseFirestore.instance
  //       .collection('posts')
  //       .doc(postId)
  //       .collection('likes')
  //       .doc(userModel!.uId)
  //       .set({'like': true}).then((value) {
  //     emit(LikePostSuccessState());
  //   }).catchError((error) {
  //     LikePostErrorState(error: error.toString());
  //   });
  // }

  //todo////////////////////////////////PostData////////////////////////////////

  getPostImage() async {
    await imagePicker.pickImage(source: ImageSource.gallery).then((value) {
      if (value != null) {
        postImage = File(value.path);
        emit(GetPostImageSuccessState());
        print(postImage);
      } else {
        emit(GetPostImageCanceledState());
      }
    }).catchError((error) {
      emit(GetPostImageErrorState(error: error.toString()));
    });
  }

  uploadPostImage({
    required String text,
    required String date,
  }) {
    emit(UploadPostImageLoadingState());
    FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createPost(text: text, date: date, postImage: value);
      }).catchError((error) {
        emit(UploadPostImageErrorState(error: error.toString()));
      });
    }).catchError((error) {
      print(error);
      emit(UploadPostImageErrorState(error: error.toString()));
    });
  }

  createPost({
    required String text,
    required String date,
    String? postImage,
  }) {
    PostModel posts = PostModel(
        image: userModel!.image,
        uId: userModel!.uId,
        name: userModel!.name,
        text: text,
        date: date,
        postImage: postImage ?? '');
    emit(CreatePostLoadingState());

    FirebaseFirestore.instance
        .collection('posts')
        .add(posts.toMap())
        .then((value) {
      emit(CreatePostSuccessState());
    }).catchError((error) {
      emit(CreatePostErrorState(error: error.toString()));
    });
  }

  getPosts() {
    emit(ChatGetPostsLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .orderBy('date',descending: true)
        .snapshots()
        .listen((event) {
      posts = [];
      myPosts = [];
     // likePostsNo = [];
      myPostImages = [];
      postId = [];
      event.docs.forEach((element) {
        // element.reference.collection('likes').snapshots().listen((event) {
        //   likePostsNo.add(event.docs.length);
        //
        // });
        postId.add(element.id);
        posts.add(PostModel.fromJson(element.data()));
        if (element.data()['uId'] == uId) {
          myPosts.add(PostModel.fromJson(element.data()));
          //متنساش قعدت فيها 15 محاوله علي اما جت
          if (element.data()['postImage'] != '')
            myPostImages.add(element.data()['postImage']);
          //print(myPostImages);
        }
      });
    });
  }

  removePostImage() {
    postImage = null;
    emit(RemovePostImageState());
  }

   deletePost({required String postId}) {
    emit(DeletePostLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .delete()
        .then((value) {
      emit(DeletePostSuccessState());
    }).catchError((error) {
      emit(DeletePostErrorState(error: error.toString()));
    });
  }

//todo////////////////////////////////StoryData////////////////////////////////

  getStoryImage() async {
    await imagePicker.pickImage(source: ImageSource.gallery).then((value) {
      if (value != null) {
        storyImage = File(value.path);
        emit(GetStoryImageSuccessState());
        print(storyImage);
      } else {
        emit(GetStoryImageCanceledState());
      }
    }).catchError((error) {
      emit(GetStoryImageErrorState(error: error.toString()));
    });
  }

  uploadStoryImage({required String date}) {
    emit(UploadStoryLoadingState());
    FirebaseStorage.instance
        .ref()
        .child('story/${Uri.file(storyImage!.path).pathSegments.last}')
        .putFile(storyImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createStory(storyImage: value, date: date);
        print(value);
      }).catchError((error) {
        emit(UploadStoryErrorState(error: error));
      });
    }).catchError((error) {
      emit(UploadStoryErrorState(error: error));
    });
  }

  createStory({String? storyImage, String? date}) {
    emit(CreateStoryLoadingState());
    StoryModel model = StoryModel(
        uId: userModel!.uId,
        name: userModel!.name,
        image: userModel!.image,
        storyImage: storyImage ?? '',
        date: date);
    FirebaseFirestore.instance
        .collection('story')
        .add(model.toMap())
        .then((value) {
      emit(CreateStorySuccessState());
    }).catchError((error) {
      emit(CreateStoryErrorState(error: error));
    });
  }

  getStory() {
    emit(GetStoryLoadingState());
    FirebaseFirestore.instance
        .collection('story')
        .orderBy('date', descending: true)
        .snapshots()
        .listen((event) {
      stories = [];
      event.docs.forEach((element) {
        stories.add(StoryModel.fromJson(element.data()));
      });
    });
  }
}

import 'package:chat_app_firebase/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'chat_register_state.dart';

class ChatRegisterCubit extends Cubit<ChatRegisterState> {
  ChatRegisterCubit() : super(ChatRegisterInitial());

  static ChatRegisterCubit get(context) => BlocProvider.of(context);
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool isPassword = true;

//todo/////////////passwordVisibility////////////////////////////////////

  void isPasswordVisibility() {
    isPassword = !isPassword;
    emit(ChatRegisterVisibilityState());
  }

//todo/////////////RegisterPost/////////////////////////////////////////////

  userRegister({
    required String name,
    required String phone,
    required String email,
    required String password,
  }) {
    emit(ChatRegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user!.email);
      print(value.user!.uid);
      userCreate(
        name: name,
        phone: phone,
        email: email,
        uId: value.user!.uid,
        cover: 'https://img.freepik.com/premium-photo/businessman-holding-hand-icon-user-manwoman-3d-style-internet-icons-interface-foreground-global-network-media-concept_150455-19928.jpg?w=1060',
        bio: 'Write your bio....',
        image: 'https://img.freepik.com/free-psd/3d-illustration-person-with-sunglasses_23-2149436188.jpg?t=st=1720966897~exp=1720970497~hmac=61d976e5a023f5f5cbc9f2cd6b4f8cd906379bae966272e627916c8829e07a50&w=740',
      );
    }).catchError((error) {
      emit(ChatRegisterErrorState(error: error.toString()));
      print(error.toString());
    });
  }

  userCreate({
    required String name,
    required String phone,
    required String email,
    required String uId,
    required String cover,
    required String bio,
    required String image,
  }) {
    UserModel model = UserModel(
        name: name,
        email: email,
        phone: phone,
        uId: uId,
        cover: cover,
        bio: bio,
        image: image);

    emit(ChatCreateUserLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(ChatCreateUserSuccessState());
    }).catchError((error) {
      emit(ChatCreateUserErrorState(error: error.toString()));
    });
  }
}

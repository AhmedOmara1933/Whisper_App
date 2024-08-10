import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'chat_login_state.dart';

class ChatLoginCubit extends Cubit<ChatLoginStates> {
  ChatLoginCubit() : super(ChatLoginInitial());

  ChatLoginCubit get(context) => BlocProvider.of(context);

  var email = TextEditingController();
  var password = TextEditingController();
  var formKey = GlobalKey<FormState>();

//todo/////////////passwordVisibility////////////////////////////////////
  bool isPassword = true;

  void isVisibility() {
    isPassword = !isPassword;
    emit(ChatLoginVisibilityState());
  }

//todo/////////////LoginPost/////////////////////////////////////////////

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(ChatLoginLoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user!.email);
      print(value.user!.uid);
      emit(ChatLoginSuccessState(uId: value.user!.uid));
    }).catchError((error) {
      print(error.toString());
      emit(ChatLoginErrorState(error: error.toString()));
    });
  }
}

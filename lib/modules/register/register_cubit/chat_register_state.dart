abstract class ChatRegisterState {}

class ChatRegisterInitial extends ChatRegisterState {}

class ChatRegisterVisibilityState extends ChatRegisterState {}

class ChatRegisterLoadingState extends ChatRegisterState {}

class ChatRegisterSuccessState extends ChatRegisterState {}

class ChatRegisterErrorState extends ChatRegisterState {
  final String error;

  ChatRegisterErrorState({required this.error});
}

class ChatCreateUserLoadingState extends ChatRegisterState {}

class ChatCreateUserSuccessState extends ChatRegisterState {}

class ChatCreateUserErrorState extends ChatRegisterState {
  final String error;

  ChatCreateUserErrorState({required this.error});
}

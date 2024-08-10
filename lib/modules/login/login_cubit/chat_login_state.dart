abstract class ChatLoginStates {}

class ChatLoginInitial extends ChatLoginStates {}

class ChatLoginVisibilityState extends ChatLoginStates {}

class ChatLoginLoadingState extends ChatLoginStates {}

class ChatLoginSuccessState extends ChatLoginStates {
  final String uId;

  ChatLoginSuccessState({required this.uId});
}

class ChatLoginErrorState extends ChatLoginStates {
  final String error;

  ChatLoginErrorState({required this.error});
}

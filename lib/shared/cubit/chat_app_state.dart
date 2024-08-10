abstract class ChatAppState {}

class ChatAppInitial extends ChatAppState {}

class ChangeBottomNavBarState extends ChatAppState {}

class AddNewPostState extends ChatAppState {}

class ChatGetUserLoadingState extends ChatAppState {}

class ChatGetUserSuccessState extends ChatAppState {}

class ChatGetUserErrorState extends ChatAppState {
  final String error;

  ChatGetUserErrorState({required this.error});
}

class ChatUpdateUserLoadingState extends ChatAppState {}

class ChatUpdateUserErrorState extends ChatAppState {}

class GetProfileImageSuccessState extends ChatAppState {}

class GetProfileImageCanceledState extends ChatAppState {}

class GetProfileImageErrorState extends ChatAppState {
  final String error;

  GetProfileImageErrorState({required this.error});
}

class UploadProfileImageSuccessState extends ChatAppState {}

class UploadProfileImageErrorState extends ChatAppState {
  final String error;

  UploadProfileImageErrorState({required this.error});
}

class GetCoverImageSuccessState extends ChatAppState {}

class GetCoverImageCanceledState extends ChatAppState {}

class GetCoverImageErrorState extends ChatAppState {
  final String error;

  GetCoverImageErrorState({required this.error});
}

class UploadCoverImageSuccessState extends ChatAppState {}

class UploadCoverImageErrorState extends ChatAppState {
  final String error;

  UploadCoverImageErrorState({required this.error});
}

class ChatUploadProfileLoadingState extends ChatAppState {}

class ChatUploadCoverLoadingState extends ChatAppState {}

class GetPostImageSuccessState extends ChatAppState {}

class GetPostImageCanceledState extends ChatAppState {}

class GetPostImageErrorState extends ChatAppState {
  final String error;

  GetPostImageErrorState({required this.error});
}

class UploadPostImageLoadingState extends ChatAppState {}

class UploadPostImageErrorState extends ChatAppState {
  final String error;

  UploadPostImageErrorState({required this.error});
}

class RemovePostImageState extends ChatAppState {}

class CreatePostLoadingState extends ChatAppState {}

class CreatePostSuccessState extends ChatAppState {}

class CreatePostErrorState extends ChatAppState {
  final String error;

  CreatePostErrorState({required this.error});
}

class ChatGetPostsLoadingState extends ChatAppState {}

class ChatGetPostsSuccessState extends ChatAppState {}

class ChatGetPostsErrorState extends ChatAppState {
  final String error;

  ChatGetPostsErrorState({required this.error});
}

class ChatGetAllUsersLoadingState extends ChatAppState {}

class ChatGetAllUsersSuccessState extends ChatAppState {}

class ChatGetAllUsersErrorState extends ChatAppState {
  final String error;

  ChatGetAllUsersErrorState({required this.error});
}

class SendMessagesSuccessState extends ChatAppState {}

class SendMessagesErrorState extends ChatAppState {
  final String error;

  SendMessagesErrorState({required this.error});
}

class ReceiveMessagesSuccessState extends ChatAppState {}

class ReceiveMessagesErrorState extends ChatAppState {
  final String error;

  ReceiveMessagesErrorState({required this.error});
}

class GetMessageSuccessState extends ChatAppState {}

class IsButtonClickedSuccessState extends ChatAppState {}

class UpdatePostsErrorState extends ChatAppState {}

class GetMessageImageSuccessState extends ChatAppState {}

class GetMessageImageCanceledState extends ChatAppState {}

class GetMessageImageErrorState extends ChatAppState {
  final String error;

  GetMessageImageErrorState({required this.error});
}

class LikePostLoadingState extends ChatAppState {}

class LikePostSuccessState extends ChatAppState {}

class LikePostErrorState extends ChatAppState {
  final String error;

  LikePostErrorState({required this.error});
}

class GetStoryImageSuccessState extends ChatAppState {}

class GetStoryImageCanceledState extends ChatAppState {}

class GetStoryImageErrorState extends ChatAppState {
  final String error;

  GetStoryImageErrorState({required this.error});
}

class CreateStoryLoadingState extends ChatAppState {}

class CreateStorySuccessState extends ChatAppState {}

class CreateStoryErrorState extends ChatAppState {
  final String error;

  CreateStoryErrorState({required this.error});
}

class UploadStoryErrorState extends ChatAppState {
  final String error;

  UploadStoryErrorState({required this.error});
}

class UploadStoryLoadingState extends ChatAppState {}

class GetStoryLoadingState extends ChatAppState {}

class GetStorySuccessState extends ChatAppState {}

class GetStoryErrorState extends ChatAppState {
  final String error;

  GetStoryErrorState({required this.error});
}

class DeletePostLoadingState extends ChatAppState {}

class DeletePostSuccessState extends ChatAppState {}

class DeletePostErrorState extends ChatAppState {
  final String error;

  DeletePostErrorState({required this.error});
}

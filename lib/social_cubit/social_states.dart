abstract class SocialStates {}

class SocialIntialState extends SocialStates {}

class SocialChangeBottomNavState extends SocialStates {}

class SocialNewPostState extends SocialStates {}

class SwitchState extends SocialStates {}

//GetUser

class SocialGetUserLoadingState extends SocialStates {}

class SocialGetUserSuccessState extends SocialStates {}

class SocialGetUserErrorState extends SocialStates {
  final String error;

  SocialGetUserErrorState(this.error);
}

//GetAllUsers

class SocialGetAllUsersLoadingState extends SocialStates {}

class SocialGetAllUsersSuccessState extends SocialStates {}

class SocialGetAllUsersErrorState extends SocialStates {
  final String error;

  SocialGetAllUsersErrorState(this.error);
}

//UserUpdate

class SocialUserUpdateLoadingState extends SocialStates {}

class SocialUserUpdateErrorState extends SocialStates {}

//ProfileImage

class SocialProfileImagePickedSuccessState extends SocialStates {}

class SocialProfileImagePickedErrorState extends SocialStates {}

class SocialUploadProfileImageErrorState extends SocialStates {}

class SocialRemoveProfileImageState extends SocialStates {}

//CoverImage

class SocialCoverImagePickedSuccessState extends SocialStates {}

class SocialCoverImagePickedErrorState extends SocialStates {}

class SocialUploadCoverImageErrorState extends SocialStates {}

class SocialRemoveCoverImageState extends SocialStates {}

//CreatPost

class SocialPostImagePickedSuccessState extends SocialStates {}

class SocialPostImagePickedErrorState extends SocialStates {}

class SocialCreatPostLoadingState extends SocialStates {}

class SocialCreatPostSuccessState extends SocialStates {}

class SocialCreatPostErrorState extends SocialStates {}

class SocialRemovePostImageState extends SocialStates {}

//GetPosts

class SocialGetPostsSuccessState extends SocialStates {}

class SocialGetPostsErrorState extends SocialStates {
  final String error;

  SocialGetPostsErrorState(this.error);
}

//DeletePost

class SocialDeletePostSuccessState extends SocialStates {}

class SocialDeletePostErrorState extends SocialStates {
  final String error;

  SocialDeletePostErrorState(this.error);
}

//Pop
class SocialPopState extends SocialStates {}

//GetPostComments

class SocialGetPostCommentsSuccessState extends SocialStates {}

class SocialGetPostCommentsErrorState extends SocialStates {
  final String error;

  SocialGetPostCommentsErrorState(this.error);
}

//LikePost

class SocialLikePostSuccessState extends SocialStates {}

class SocialLikePostErrorState extends SocialStates {
  final String error;

  SocialLikePostErrorState(this.error);
}

//GetPostComments

class SocialGetPostLikesSuccessState extends SocialStates {}

class SocialGetPostLikesErrorState extends SocialStates {
  final String error;

  SocialGetPostLikesErrorState(this.error);
}

class SocialDisLikePostSuccessState extends SocialStates {}

class SocialDisLikePostErrorState extends SocialStates {
  final String error;

  SocialDisLikePostErrorState(this.error);
}

//CommentOnPost

class SocialCommentOnPostSuccessState extends SocialStates {}

class SocialCommentOnPostErrorState extends SocialStates {
  final String error;

  SocialCommentOnPostErrorState(this.error);
}

//GetSinglePost

class SocialGetSinglePostSuccess extends SocialStates {}

class SocialGetSinglePostError extends SocialStates {}

class SocialGetSinglePostLikesSuccess extends SocialStates {}

class SocialGetSinglePostCommentsSuccess extends SocialStates {}

//Message

class SocialSendMessageSuccess extends SocialStates {}

class SocialSendMessageError extends SocialStates {
  final String error;

  SocialSendMessageError(this.error);
}

class SocialGetMessageLoading extends SocialStates {}

class SocialGetMessageSuccess extends SocialStates {}

//UpdatePostsData

class SocialUpdatePostsDataSuccessState extends SocialStates {}

class SocialUpdatePostsDataErrorState extends SocialStates {
  final String error;

  SocialUpdatePostsDataErrorState(this.error);
}

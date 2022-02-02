abstract class LoginStates {}

class SocialLoginIntialState extends LoginStates {}

class SocialChangePasswordVisibilityState extends LoginStates {}

class SocialLoginLoadingState extends LoginStates {}

class SocialLoginSuccessState extends LoginStates {
  final String uId;

  SocialLoginSuccessState(this.uId);
}

class SocialLoginErrorState extends LoginStates {
  final String error;

  SocialLoginErrorState(this.error);
}

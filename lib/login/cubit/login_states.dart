abstract class LoginStates {}

class ShopLoginIntialState extends LoginStates {}

class ShopChangePasswordVisibilityState extends LoginStates {}

class ShopLoginLoadingState extends LoginStates {}

class ShopLoginSuccessState extends LoginStates {
  final String uId;

  ShopLoginSuccessState(this.uId);
}

class ShopLoginErrorState extends LoginStates {
  final String error;

  ShopLoginErrorState(this.error);
}

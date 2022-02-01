abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates {}

class RegisterChangePasswordVisibilityState extends RegisterStates {}

class RegisterLoadingState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {}

class RegisterErrorState extends RegisterStates {
  final String error;

  RegisterErrorState(this.error);
}

class CreatUserSuccessState extends RegisterStates {}

class CreatUserErrorState extends RegisterStates {
  final String error;

  CreatUserErrorState(this.error);
}

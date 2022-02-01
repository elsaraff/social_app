import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:social_application/login/cubit/login_states.dart';
import 'package:social_application/widgets/show_toast.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(ShopLoginIntialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    suffix =
        isPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    isPassword = !isPassword;
    emit(ShopChangePasswordVisibilityState());
  }

  void userLogin({
    @required String email,
    @required String password,
  }) {
    emit(ShopLoginLoadingState());

    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      showToast(text: 'Hello', state: ToastStates.success);
      emit(ShopLoginSuccessState(value.user.uid.toString()));
    }).catchError((error) {
      showToast(text: error.toString(), state: ToastStates.error);
      emit(ShopLoginErrorState(error.toString()));
    });
  }
}

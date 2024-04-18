import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_application/login/cubit/login_states.dart';
import 'package:social_application/widgets/functions.dart';
import 'package:social_application/widgets/show_toast.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(SocialLoginIntialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    suffix =
        isPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    isPassword = !isPassword;
    emit(SocialChangePasswordVisibilityState());
  }

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(SocialLoginLoadingState());

    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      showToast(text: 'Hello', state: ToastStates.success);
      emit(SocialLoginSuccessState(value.user!.uid.toString()));
    }).catchError((error) {
      showToast(text: error.toString(), state: ToastStates.error);
      emit(SocialLoginErrorState(error.toString()));
    });
  }

  void updateToken(String token) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('token')
        .doc(uId)
        .update({'token': token});
  }
}

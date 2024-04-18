import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_application/core/cache_helper.dart';
import 'package:social_application/models/user_model.dart';
import 'package:social_application/register/cubit/register_state.dart';
import 'package:social_application/widgets/functions.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;

    emit(RegisterChangePasswordVisibilityState());
  }

  void userRegister({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) {
    emit(RegisterLoadingState());

    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      CacheHelper.saveData(key: 'uId', value: value.user!.uid);
      uId = value.user!.uid;
      userCreat(
        name: name,
        email: email,
        phone: phone,
        uId: value.user!.uid,
      );
      emit(RegisterSuccessState());
    }).catchError((error) {
      emit(RegisterErrorState(error.toString()));
    });
  }

  void userCreat({
    required String name,
    required String email,
    required String phone,
    required String uId,
  }) {
    SocialUserModel model = SocialUserModel(
      name: name,
      email: email,
      phone: phone,
      bio: 'write your bio ..',
      uId: uId,
      announcement: true,
      image:
          'https://www.minervastrategies.com/wp-content/uploads/2016/03/default-avatar.jpg',
      cover:
          'https://thumbs.dreamstime.com/b/blue-gray-concrete-wall-cement-background-grunge-stone-texture-design-element-bright-pattern-abstract-style-blue-gray-155189477.jpg',
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .collection('token')
        .doc(uId)
        .set({'token': token});

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(CreatUserSuccessState());
    }).catchError((error) {
      emit(CreatUserErrorState(error.toString()));
    });
  }
}

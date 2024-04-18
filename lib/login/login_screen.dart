import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_application/core/cache_helper.dart';
import 'package:social_application/home_screen.dart';
import 'package:social_application/shared/icons_broken.dart';
import 'package:social_application/social_cubit/social_cubit.dart';
import 'package:social_application/widgets/custom_text_form_field.dart';
import 'package:social_application/widgets/functions.dart';
import 'package:social_application/login/cubit/login_cubit.dart';
import 'package:social_application/login/cubit/login_states.dart';
import 'package:social_application/register/register_screen.dart';
import 'package:social_application/widgets/show_toast.dart';

var formKey = GlobalKey<FormState>();
var emailController = TextEditingController();
var passwordController = TextEditingController();

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {
          if (state is SocialLoginErrorState) {
            showToast(text: state.error, state: ToastStates.error);
          }
          if (state is SocialLoginSuccessState) {
            CacheHelper.saveData(key: 'uId', value: state.uId).then((value) {
              uId = state.uId;
              navigateAndFinish(context, const HomeScreen());
              emailController.clear();
              passwordController.clear();

              LoginCubit.get(context).updateToken(token!);

              if (firstTime == false) {
                SocialCubit.get(context).getUserData();
                SocialCubit.get(context).getPosts();
              }
            });
          }
        },
        builder: (context, state) {
          var loginCubit = LoginCubit.get(context);

          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Login',
                            style: TextStyle(
                                fontSize: 40.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueGrey)),
                        const SizedBox(height: 20.0),
                        const Text('Login to connect with friends.',
                            style:
                                TextStyle(fontSize: 20.0, color: Colors.grey)),
                        const SizedBox(height: 60.0),
                        customTextFormField(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            validate: (String value) {
                              if (value.isEmpty) {
                                return "Email is Empty";
                              }
                              return null;
                            },
                            label: 'Email Address',
                            prefix: IconBroken.Message),
                        const SizedBox(height: 20.0),
                        customTextFormField(
                            controller: passwordController,
                            type: TextInputType.visiblePassword,
                            isPassword: loginCubit.isPassword,
                            validate: (String value) {
                              if (value.isEmpty) {
                                return "password is Empty";
                              }
                              return null;
                            },
                            label: 'Password',
                            prefix: IconBroken.Password,
                            suffix: loginCubit.suffix,
                            suffixPressed: () {
                              loginCubit.changePasswordVisibility();
                            }),
                        const SizedBox(height: 20.0),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.blueGrey,
                              borderRadius: BorderRadius.circular(10)),
                          width: double.infinity,
                          child: MaterialButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                loginCubit.userLogin(
                                    email: emailController.text,
                                    password: passwordController.text);
                              }
                            },
                            child: const Text(
                              'LOGIN',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25.0,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Don\'t have account ?',
                              style: TextStyle(fontSize: 20),
                            ),
                            TextButton(
                                onPressed: () {
                                  navigateTo(context, const RegisterScreen());
                                },
                                child: const Text(
                                  'Register',
                                  style: TextStyle(
                                      fontSize: 20,
                                      decoration: TextDecoration.underline),
                                ))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

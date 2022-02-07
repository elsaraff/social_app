import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_application/home_screen.dart';
import 'package:social_application/shared/icons_broken.dart';
import 'package:social_application/social_cubit/social_cubit.dart';
import 'package:social_application/widgets/custom_text_form_field.dart';
import 'package:social_application/register/cubit/register_cubit.dart';
import 'package:social_application/register/cubit/register_state.dart';
import 'package:social_application/widgets/functions.dart';

var formKey = GlobalKey<FormState>();
var nameController = TextEditingController();
var emailController = TextEditingController();
var phoneController = TextEditingController();
var passwordController = TextEditingController();

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => RegisterCubit(),
        child: BlocConsumer<RegisterCubit, RegisterStates>(
          listener: (context, state) {
            if (state is CreatUserSuccessState) {
              navigateAndFinish(context, const HomeScreen());
              nameController.clear();
              emailController.clear();
              phoneController.clear();
              passwordController.clear();

              if (firstTime == false) {
                SocialCubit.get(context).getUserData();
                SocialCubit.get(context).getPosts();
              }
            }
          },
          builder: (context, state) {
            var registerCubit = RegisterCubit.get(context);

            return SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          const Text('Register',
                              style: TextStyle(
                                  fontSize: 40.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueGrey)),
                          const SizedBox(height: 20.0),
                          const Text('Creat A New Account.',
                              style: TextStyle(
                                  fontSize: 20.0, color: Colors.grey)),
                          const SizedBox(height: 40.0),
                          customTextFormField(
                              controller: nameController,
                              type: TextInputType.text,
                              validate: (value) {
                                if (value.isEmpty) {
                                  return "Name is empty ";
                                }
                                return null;
                              },
                              label: 'Name',
                              prefix: IconBroken.User),
                          const SizedBox(height: 10),
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
                          const SizedBox(height: 10),
                          customTextFormField(
                              controller: phoneController,
                              type: TextInputType.phone,
                              validate: (String value) {
                                if (value.isEmpty) {
                                  return "Phone is Empty";
                                }
                                return null;
                              },
                              label: 'Phone Number',
                              prefix: IconBroken.Call),
                          const SizedBox(height: 10),
                          customTextFormField(
                              controller: passwordController,
                              type: TextInputType.visiblePassword,
                              isPassword: registerCubit.isPassword,
                              validate: (value) {
                                if (value.isEmpty) {
                                  return 'Password is  empty';
                                }
                                return null;
                              },
                              label: 'Password',
                              prefix: IconBroken.Password,
                              suffix: registerCubit.suffix,
                              suffixPressed: () {
                                registerCubit.changePasswordVisibility();
                              }),
                          const SizedBox(height: 20),
                          ConditionalBuilder(
                            condition: state is! RegisterLoadingState,
                            builder: (context) => Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15.0),
                                  color: Colors.blueGrey),
                              child: MaterialButton(
                                child: const Text(
                                  'Register',
                                  style: TextStyle(color: Colors.white),
                                ),
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    registerCubit.userRegister(
                                        name: nameController.text,
                                        email: emailController.text,
                                        phone: phoneController.text,
                                        password: passwordController.text);
                                  }
                                },
                              ),
                            ),
                            fallback: (context) => const Center(
                                child: CircularProgressIndicator()),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

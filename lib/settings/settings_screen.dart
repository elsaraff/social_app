import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_application/edit_profile/edit_profile.dart';
import 'package:social_application/shared/icons_broken.dart';
import 'package:social_application/social_cubit/social_cubit.dart';
import 'package:social_application/social_cubit/social_states.dart';
import 'package:social_application/widgets/functions.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = SocialCubit.get(context).userModel;
        var socialCubit = SocialCubit.get(context);

        return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ConditionalBuilder(
              condition: userModel != null,
              fallback: (context) =>
                  const Center(child: CircularProgressIndicator()),
              builder: (context) => Column(
                children: [
                  SizedBox(
                    height: 210,
                    child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          alignment: AlignmentDirectional.topCenter,
                          child: InkWell(
                            child: Container(
                                height: 180,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                        topRight: Radius.circular(4),
                                        topLeft: Radius.circular(4)),
                                    image: DecorationImage(
                                      image: NetworkImage(userModel.cover),
                                      fit: BoxFit.cover,
                                    ))),
                            onTap: () {},
                          ),
                        ),
                        CircleAvatar(
                          radius: 59,
                          backgroundColor: Colors.white,
                          child: InkWell(
                            child: CircleAvatar(
                                radius: 55,
                                backgroundImage: NetworkImage(userModel.image)),
                            onTap: () {},
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  Text(userModel.name,
                      style: const TextStyle(
                        fontSize: 20,
                        height: 1.6,
                        fontWeight: FontWeight.bold,
                      )),
                  InkWell(
                    child: Text(
                      userModel.bio.toString(),
                      style: const TextStyle(height: 1.6),
                      maxLines: 3,
                      textAlign: TextAlign.center,
                    ),
                    onTap: () {},
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                        width: double.infinity,
                        height: 2.0,
                        color: Colors.grey[300]),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          child: Column(
                            children: const [
                              Text('157',
                                  style: TextStyle(
                                      fontSize: 15,
                                      height: 1.6,
                                      fontWeight: FontWeight.bold)),
                              Text('Posts',
                                  style: TextStyle(
                                    fontSize: 15,
                                    height: 1.6,
                                  )),
                            ],
                          ),
                          onTap: () {},
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          child: Column(
                            children: const [
                              Text('57',
                                  style: TextStyle(
                                      fontSize: 15,
                                      height: 1.6,
                                      fontWeight: FontWeight.bold)),
                              Text('Photos',
                                  style: TextStyle(
                                    fontSize: 15,
                                    height: 1.6,
                                  )),
                            ],
                          ),
                          onTap: () {},
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          child: Column(
                            children: const [
                              Text('396',
                                  style: TextStyle(
                                      fontSize: 15,
                                      height: 1.6,
                                      fontWeight: FontWeight.bold)),
                              Text('Followers',
                                  style: TextStyle(
                                    fontSize: 15,
                                    height: 1.6,
                                  )),
                            ],
                          ),
                          onTap: () {},
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          child: Column(
                            children: const [
                              Text('812',
                                  style: TextStyle(
                                      fontSize: 15,
                                      height: 1.6,
                                      fontWeight: FontWeight.bold)),
                              Text('Following',
                                  style: TextStyle(
                                    fontSize: 15,
                                    height: 1.6,
                                  )),
                            ],
                          ),
                          onTap: () {},
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 33,
                    child: Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {},
                            child: const Text('Add Photos',
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blueGrey)),
                          ),
                        ),
                        const SizedBox(width: 10),
                        OutlinedButton(
                          onPressed: () {
                            navigateTo(context, const EditProfileScreen());
                          },
                          child: const Icon(IconBroken.Edit, size: 17),
                        ),
                        const SizedBox(width: 10),
                        OutlinedButton(
                          onPressed: () {
                            socialCubit.logOut(context);
                          },
                          child: const Icon(IconBroken.Logout, size: 17),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                            onPressed: () {
                              FirebaseMessaging.instance
                                  .subscribeToTopic('announcement');
                            },
                            child: const Text('Subscribe')),
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: OutlinedButton(
                            onPressed: () {
                              FirebaseMessaging.instance
                                  .unsubscribeFromTopic('announcement');
                            },
                            child: const Text('UnSubscribe')),
                      ),
                    ],
                  ),
                ],
              ),
            ));
      },
    );
  }
}

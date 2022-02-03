import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_application/friends/profile_details_screen.dart';
import 'package:social_application/models/user_model.dart';
import 'package:social_application/social_cubit/social_cubit.dart';
import 'package:social_application/social_cubit/social_states.dart';
import 'package:social_application/widgets/functions.dart';

class FriendsScreen extends StatelessWidget {
  const FriendsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var users = SocialCubit.get(context).allUsers;
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ConditionalBuilder(
              condition: users.isNotEmpty,
              builder: (context) => ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) =>
                      buildProfileItem(users[index], context),
                  separatorBuilder: (context, index) => Container(
                        color: Colors.blueGrey,
                        width: double.infinity,
                        height: 0.5,
                      ),
                  itemCount: users.length),
              fallback: (context) => const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildProfileItem(SocialUserModel model, context) => InkWell(
        onTap: () {
          navigateTo(context, ProfileDetailsScreen(userModel: model));
        },
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              CircleAvatar(
                  radius: 25, backgroundImage: NetworkImage(model.image)),
              const SizedBox(width: 15),
              Text(model.name,
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.6,
                    fontWeight: FontWeight.bold,
                  )),
            ],
          ),
        ),
      );
}

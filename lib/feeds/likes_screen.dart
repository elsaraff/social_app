import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_application/friends/profile_details_screen.dart';
import 'package:social_application/shared/icons_broken.dart';
import 'package:social_application/social_cubit/social_cubit.dart';
import 'package:social_application/social_cubit/social_states.dart';
import 'package:social_application/widgets/functions.dart';

class LikesScreen extends StatelessWidget {
  const LikesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(IconBroken.Arrow___Left, color: Colors.white)),
            titleSpacing: 0.0,
            title: SocialCubit.get(context).postLikes.length > 1
                ? Text(SocialCubit.get(context).postLikes.length.toString() +
                    ' Likes')
                : Text(SocialCubit.get(context).postLikes.length.toString() +
                    ' Like'),
          ),
          body: ConditionalBuilder(
            condition: SocialCubit.get(context).postLikes.isNotEmpty,
            builder: (context) => SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => buildLikesItem(
                    context,
                    index,
                  ),
                  separatorBuilder: (context, index) =>
                      Container(color: Colors.blueGrey, height: 1),
                  itemCount: SocialCubit.get(context).postLikes.length,
                ),
              ),
            ),
            fallback: (context) =>
                const Center(child: CircularProgressIndicator()),
          ),
        );
      },
    );
  }

  Widget buildLikesItem(
    context,
    index,
  ) {
    var postLikes = SocialCubit.get(context).postLikes;
    var likeUserInfo = SocialCubit.get(context).likeUserInfo;

    return InkWell(
      onTap: () {
        navigateTo(
            context, ProfileDetailsScreen(userModel: likeUserInfo[index]));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(postLikes[index].image)),
            const SizedBox(width: 10),
            Column(
              children: [
                Text(postLikes[index].name,
                    style: const TextStyle(
                      fontSize: 14,
                      height: 1.6,
                      fontWeight: FontWeight.bold,
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ScaleTransition1 extends PageRouteBuilder {
  final Widget page;

  ScaleTransition1(this.page)
      : super(
          pageBuilder: (context, animation, anotherAnimation) => page,
          transitionDuration: const Duration(milliseconds: 1000),
          reverseTransitionDuration: const Duration(milliseconds: 200),
          transitionsBuilder: (context, animation, anotherAnimation, child) {
            animation = CurvedAnimation(
                curve: Curves.fastLinearToSlowEaseIn,
                parent: animation,
                reverseCurve: Curves.fastOutSlowIn);
            return ScaleTransition(
              alignment: Alignment.bottomCenter,
              scale: animation,
              child: child,
            );
          },
        );
}

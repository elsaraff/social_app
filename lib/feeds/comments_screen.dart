import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_application/friends/profile_details_screen.dart';
import 'package:social_application/models/comment_model.dart';
import 'package:social_application/shared/icons_broken.dart';
import 'package:social_application/social_cubit/social_cubit.dart';
import 'package:social_application/social_cubit/social_states.dart';
import 'package:social_application/widgets/functions.dart';

class CommentsScreen extends StatelessWidget {
  const CommentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        var commentUserInfo = SocialCubit.get(context).commentUserInfo;

        if (state is SocialCommentsUIDSuccessState) {
          SocialCubit.get(context).s(state.id);
          navigateTo(
              context, ProfileDetailsScreen(userModel: commentUserInfo.last));
        }
      },
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon:
                      const Icon(IconBroken.Arrow___Left, color: Colors.white)),
              titleSpacing: 0.0,
              title: SocialCubit.get(context).postComments.length > 1
                  ? Text(
                      '${SocialCubit.get(context).postComments.length} Comments')
                  : Text(
                      '${SocialCubit.get(context).postComments.length} Comment'),
            ),
            body: ConditionalBuilder(
              condition: SocialCubit.get(context).postComments.isNotEmpty,
              builder: (context) => SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => buildCommentItem(
                      SocialCubit.get(context).postComments[index],
                      context,
                    ),
                    separatorBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(color: Colors.blueGrey, height: 1),
                    ),
                    itemCount: SocialCubit.get(context).postComments.length,
                  ),
                ),
              ),
              fallback: (context) =>
                  const Center(child: CircularProgressIndicator()),
            ));
      },
    );
  }

  Widget buildCommentItem(
    CommentModel comment,
    context,
  ) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey.withOpacity(.2)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            InkWell(
              onTap: () {
                SocialCubit.get(context).getCommentUserInfo(comment.uId);
              },
              child: CircleAvatar(
                  radius: 25, backgroundImage: NetworkImage(comment.image)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Container(color: Colors.blueGrey, width: 5),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {},
                    child: Row(
                      children: [
                        Text(comment.name,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            )),
                        const SizedBox(width: 4),
                        const Icon(Icons.check_circle,
                            color: Colors.blueGrey, size: 13),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      comment.comment,
                      style: const TextStyle(color: Colors.black, fontSize: 17),
                    ),
                  ),
                  Text(
                    comment.dateTime,
                    style: TextStyle(color: Colors.grey[500], fontSize: 11),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ScaleTransition2 extends PageRouteBuilder {
  final Widget page;

  ScaleTransition2(this.page)
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

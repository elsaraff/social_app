import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_view/photo_view.dart';
import 'package:social_application/feeds/comments_screen.dart';
import 'package:social_application/feeds/likes_screen.dart';
import 'package:social_application/friends/profile_details_screen.dart';
import 'package:social_application/widgets/image_wrapper.dart';
import 'package:social_application/models/post_model.dart';
import 'package:social_application/shared/icons_broken.dart';
import 'package:social_application/social_cubit/social_cubit.dart';
import 'package:social_application/social_cubit/social_states.dart';
import 'package:social_application/widgets/functions.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var posts = SocialCubit.get(context).posts;
        return ConditionalBuilder(
            condition: posts.isNotEmpty,
            builder: (context) => RefreshIndicator(
                  color: Colors.blueGrey,
                  displacement: 20,
                  edgeOffset: 20,
                  onRefresh: () => SocialCubit.get(context).getPosts(),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        Card(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          elevation: 10.0,
                          margin: const EdgeInsets.all(8.0),
                          child: Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              const Image(
                                image: AssetImage('assets/images/social.jpg'),
                                fit: BoxFit.cover,
                                height: 200,
                                width: double.infinity,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Container(
                                    color: Colors.white70,
                                    child: const Text(
                                      'Communicate With Friends',
                                      style: TextStyle(
                                          color: Colors.blueGrey,
                                          fontWeight: FontWeight.bold),
                                    )),
                              ),
                            ],
                          ),
                        ),
                        ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) => buildPostItem(
                                  SocialCubit.get(context).likedPosts,
                                  SocialCubit.get(context).postsLikes,
                                  SocialCubit.get(context).postsComments,
                                  SocialCubit.get(context).postsId[index],
                                  SocialCubit.get(context).posts[index],
                                  context,
                                  index,
                                ),
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 10),
                            itemCount: posts.length),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
            fallback: (context) =>
                const Center(child: CircularProgressIndicator()));
      },
    );
  }

  Widget buildPostItem(
    List<String> likedPosts,
    Map<String, int> likes,
    Map<String, int> comments,
    String postId,
    PostModel postModel,
    BuildContext context,
    index,
  ) {
    var commentController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    var postUserInfo = SocialCubit.get(context).postUserInfo;

    return Form(
      key: formKey,
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 5.0,
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      navigateTo(context,
                          ProfileDetailsScreen(userModel: postUserInfo[index]));
                    },
                    child: CircleAvatar(
                        radius: 25,
                        backgroundImage: NetworkImage(postModel.image)),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                        InkWell(
                          onTap: () {
                            navigateTo(
                                context,
                                ProfileDetailsScreen(
                                    userModel: postUserInfo[index]));
                          },
                          child: Row(
                            children: [
                              Text(postModel.name,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    height: 1.6,
                                    fontWeight: FontWeight.bold,
                                  )),
                              const SizedBox(width: 4),
                              const Icon(
                                Icons.check_circle,
                                color: Colors.blueGrey,
                                size: 13,
                              ),
                            ],
                          ),
                        ),
                        Text(
                          postModel.dateTime,
                          style: TextStyle(
                            color: Colors.grey[500],
                            height: 1.6,
                            fontSize: 12,
                          ),
                        ),
                      ])),
                  if (postModel.uId == FirebaseAuth.instance.currentUser!.uid)
                    PopupMenuButton(
                        itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                              PopupMenuItem(
                                child: TextButton(
                                  child: const Text('Remove Post'),
                                  onPressed: () {
                                    var alert = AlertDialog(
                                      title: const Text('Alert ! '),
                                      content: SizedBox(
                                        width: 150,
                                        height: 150,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 10.0),
                                              child: Container(
                                                  color: Colors.blueGrey,
                                                  height: 1,
                                                  width: double.infinity),
                                            ),
                                            const Text(
                                                'Are you sure you want to delete the post ?'),
                                            const Spacer(),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text('NO'),
                                                ),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    SocialCubit.get(context)
                                                        .deletePost(postId);
                                                    Navigator.pop(context);
                                                  },
                                                  child: const Text('YES'),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                    Navigator.pop(context);
                                    showDialog(
                                        barrierColor:
                                            Colors.grey.withOpacity(.2),
                                        barrierLabel: 'alert',
                                        context: context,
                                        builder: (context) => alert);
                                  },
                                ),
                              ),
                            ]),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Container(
                    width: double.infinity,
                    height: 1.0,
                    color: Colors.grey[300]),
              ),
              if (postModel.text != '')
                Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: Text(
                    postModel.text,
                    style: const TextStyle(height: 1.3),
                  ),
                ),
/* SizedBox(
                  width: double.infinity,
                  child: Wrap(
                    children: [
                      SizedBox(
                        height: 25.0,
                        child: MaterialButton(
                          onPressed: () {},
                          height: 25.0,
                          minWidth: 1,
                          padding: EdgeInsets.zero,
                          child: const Text('#Flutter',
                              style: TextStyle(color: Colors.blueGrey)),
                        ),
                      ),
                      SizedBox(
                        height: 25.0,
                        child: MaterialButton(
                          onPressed: () {},
                          height: 25.0,
                          minWidth: 1,
                          padding: EdgeInsets.zero,
                          child: const Text('#Development',
                              style: TextStyle(color: Colors.blueGrey)),
                        ),
                      ),
                      SizedBox(
                        height: 25.0,
                        child: MaterialButton(
                          onPressed: () {},
                          height: 25.0,
                          minWidth: 1,
                          padding: EdgeInsets.zero,
                          child: const Text('#Mobile_Applications',
                              style: TextStyle(color: Colors.blueGrey)),
                        ),
                      ),
                      SizedBox(
                        height: 25.0,
                        child: MaterialButton(
                          onPressed: () {},
                          height: 25.0,
                          minWidth: 1,
                          padding: EdgeInsets.zero,
                          child: const Text('#Soical_Media',
                              style: TextStyle(color: Colors.blueGrey)),
                        ),
                      ),
                    ],
                  ),
                ), */
              if (postModel.postImage != '')
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: InkWell(
                    onTap: () {
                      navigateTo(
                        context,
                        ImageWrapper(
                          imageProvider: NetworkImage(postModel.postImage),
                          backgroundDecoration:
                              const BoxDecoration(color: Colors.black),
                          minScale: PhotoViewComputedScale.contained * 1,
                          maxScale: PhotoViewComputedScale.covered * 2,
                          loadingBuilder: (context, event) {
                            if (event == null) {
                              return const Center(
                                child: Text("Loading"),
                              );
                            }
                            final value = event.cumulativeBytesLoaded /
                                (event.expectedTotalBytes ??
                                    event.cumulativeBytesLoaded);

                            final percentage = (100 * value).floor();
                            return Center(
                              child: Column(
                                children: [
                                  const CircularProgressIndicator(),
                                  Text("$percentage%"),
                                ],
                              ),
                            );
                          },
                        ),
                      );
                    },
                    child: Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.0),
                            image: DecorationImage(
                              image: NetworkImage(postModel.postImage),
                              fit: BoxFit.contain,
                            ))),
                  ),
                ),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        SocialCubit.get(context).getPostLikes(postId);
                        if (likes[postId]! >= 1) {
                          Navigator.push(
                              context, ScaleTransition1(const LikesScreen()));
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            if (!likedPosts.contains(postId))
                              const Icon(Icons.favorite_border,
                                  color: Colors.red, size: 25),
                            if (likedPosts.contains(postId))
                              const Icon(Icons.favorite,
                                  color: Colors.red, size: 25),
                            const SizedBox(width: 5.0),
                            Text(likes[postId].toString()),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        SocialCubit.get(context).getPostComments(postId);
                        if (comments[postId]! >= 1) {
                          Navigator.push(context,
                              ScaleTransition2(const CommentsScreen()));
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Icon(
                              IconBroken.Paper,
                              size: 20,
                            ),
                            const SizedBox(width: 5.0),
                            Text(comments[postId].toString()),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                  width: double.infinity, height: 1.0, color: Colors.grey[300]),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              navigateTo(
                                  context,
                                  ProfileDetailsScreen(
                                      userModel:
                                          SocialCubit.get(context).userModel));
                            },
                            child: CircleAvatar(
                                radius: 19,
                                backgroundImage: NetworkImage(
                                    SocialCubit.get(context).userModel!.image)),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextFormField(
                              controller: commentController,
                              keyboardType: TextInputType.multiline,
                              minLines: 1,
                              maxLines: 4,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.blueGrey[10],
                                border: InputBorder.none,
                                hintText: 'Write a comment ...',
                              ),
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Comment is empty ";
                                }
                                return null;
                              },
                            ),
                          ),
                          InkWell(
                              onTap: () {
                                if (formKey.currentState!.validate()) {
                                  SocialCubit.get(context).commentOnPost(
                                    name: SocialCubit.get(context)
                                        .userModel!
                                        .name,
                                    image: SocialCubit.get(context)
                                        .userModel!
                                        .image,
                                    uId:
                                        SocialCubit.get(context).userModel!.uId,
                                    postId: postId,
                                    comment: commentController.text,
                                    dateTime: now.toString(),
                                    time: DateTime.now().toString(),
                                  );
                                  commentController.clear();
                                }
                              },
                              child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 7.0, horizontal: 7.0),
                                  child: Row(children: const [
                                    Icon(Icons.comment_bank_outlined,
                                        color: Colors.blueGrey, size: 25)
                                  ]))),
                          if (!likedPosts.contains(postId))
                            InkWell(
                                onTap: () {
                                  SocialCubit.get(context).likePost(
                                    postId,
                                    DateTime.now().toString(),
                                  );
                                },
                                child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 7.0, vertical: 7.0),
                                    child: Row(children: const [
                                      Icon(Icons.favorite_border,
                                          color: Colors.red, size: 25),
                                    ]))),
                          if (likedPosts.contains(postId))
                            InkWell(
                                onTap: () {
                                  SocialCubit.get(context).dislikePost(postId);
                                },
                                child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 7.0, vertical: 7.0),
                                    child: Row(children: const [
                                      Icon(Icons.favorite,
                                          color: Colors.red, size: 25),
                                    ]))),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

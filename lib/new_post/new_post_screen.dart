import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_application/shared/icons_broken.dart';
import 'package:social_application/social_cubit/social_cubit.dart';
import 'package:social_application/social_cubit/social_states.dart';
import 'package:social_application/widgets/functions.dart';
import 'package:social_application/widgets/show_toast.dart';

var postController = TextEditingController();

class NewPostScreen extends StatelessWidget {
  const NewPostScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        if (state is SocialCreatPostSuccessState) {
          SocialCubit.get(context).getPosts();
        }
      },
      builder: (context, state) {
        var userModel = SocialCubit.get(context).userModel;
        var socialCubit = SocialCubit.get(context);

        return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: const Icon(
                  IconBroken.Arrow___Left,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                  postController.clear();
                  socialCubit.removePostImage();
                },
              ),
              title: const Text('Creat Post'),
              titleSpacing: 5.0,
            ),
            body: ConditionalBuilder(
                condition: userModel != null,
                fallback: (context) =>
                    const Center(child: CircularProgressIndicator()),
                builder: (context) => Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                      children: [
                        if (state is SocialCreatPostLoadingState)
                          const Padding(
                            padding: EdgeInsets.only(bottom: 8.0),
                            child: LinearProgressIndicator(),
                          ),
                        Row(
                          children: [
                            CircleAvatar(
                                radius: 25,
                                backgroundImage: NetworkImage(userModel.image)),
                            const SizedBox(width: 15),
                            Text(userModel.name,
                                style: const TextStyle(
                                  fontSize: 14,
                                  height: 1.6,
                                  fontWeight: FontWeight.bold,
                                )),
                          ],
                        ),
                        const SizedBox(height: 15),
                        Expanded(
                          flex: 1,
                          child: TextFormField(
                            controller: postController,
                            keyboardType: TextInputType.multiline,
                            minLines: 1,
                            maxLines: 6,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.blueGrey[50],
                              hintText: 'What\'s on your mind?',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                        if (socialCubit.postImage != null)
                          Expanded(
                            flex: 3,
                            child: InkWell(
                              child: Stack(
                                alignment: AlignmentDirectional.topEnd,
                                children: [
                                  Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(5)),
                                          image: DecorationImage(
                                            image: FileImage(
                                                socialCubit.postImage),
                                          ))),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: 25,
                                      height: 25,
                                      color: Colors.white.withOpacity(.3),
                                      child: IconButton(
                                          padding: EdgeInsets.zero,
                                          onPressed: () {
                                            socialCubit.removePostImage();
                                          },
                                          icon: const Icon(
                                            Icons.close_sharp,
                                            size: 20,
                                          )),
                                    ),
                                  ),
                                ],
                              ),
                              onTap: () {},
                            ),
                          ),
                        Row(
                          children: [
                            const SizedBox(height: 50),
                            Expanded(
                              child: TextButton(
                                  onPressed: () {
                                    socialCubit.getPostImage();
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(IconBroken.Image),
                                      SizedBox(width: 5),
                                      Text('add photo'),
                                    ],
                                  )),
                            ),
                            Expanded(
                              child: TextButton(
                                  onPressed: () {},
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Text('#',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 22)),
                                      SizedBox(width: 5),
                                      Text('tags'),
                                    ],
                                  )),
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.blueGrey[100],
                                    borderRadius: BorderRadius.circular(15)),
                                child: TextButton(
                                    onPressed: () {
                                      if (socialCubit.postImage == null &&
                                          postController.text != '') {
                                        socialCubit.creatPost(
                                            dateTime: now.toString(),
                                            time: DateTime.now().toString(),
                                            text: postController.text);
                                        showToast(
                                            text: 'Your post was shared.',
                                            state: ToastStates.success);
                                      } else if (socialCubit.postImage !=
                                          null) {
                                        socialCubit.uploadPostImage(
                                            dateTime: now.toString(),
                                            time: DateTime.now().toString(),
                                            text: postController.text);
                                        showToast(
                                            text: 'Your post was shared.',
                                            state: ToastStates.success);
                                      } else {
                                        debugPrint('Post is Empty');
                                      }
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Icon(IconBroken.Paper_Upload),
                                        SizedBox(width: 5),
                                        Text('Post',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17)),
                                      ],
                                    )),
                              ),
                            ),
                          ],
                        )
                      ],
                    ))));
      },
    );
  }
}

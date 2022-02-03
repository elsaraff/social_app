import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_application/friends/profile_details_screen.dart';
import 'package:social_application/models/message_model.dart';
import 'package:social_application/models/user_model.dart';
import 'package:social_application/shared/icons_broken.dart';
import 'package:social_application/social_cubit/social_cubit.dart';
import 'package:social_application/social_cubit/social_states.dart';
import 'package:social_application/widgets/functions.dart';

var messageController = TextEditingController();

class ChatDetailsScreen extends StatelessWidget {
  final SocialUserModel userModel;
  const ChatDetailsScreen({Key key, this.userModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      SocialCubit.get(context).getMessages(receiverId: userModel.uId);
      return BlocConsumer<SocialCubit, SocialStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(IconBroken.Arrow___Left,
                        color: Colors.white)),
                titleSpacing: 0.0,
                title: InkWell(
                  onTap: () {
                    navigateTo(
                        context, ProfileDetailsScreen(userModel: userModel));
                  },
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 20.0,
                        backgroundImage: NetworkImage(userModel.image),
                      ),
                      const SizedBox(width: 15),
                      Text(userModel.name),
                    ],
                  ),
                ),
              ),
              body: ConditionalBuilder(
                condition: state is SocialGetMessageLoading,
                builder: (context) =>
                    const Center(child: CircularProgressIndicator()),
                fallback: (context) => Form(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Column(
                      children: [
                        ConditionalBuilder(
                            condition:
                                SocialCubit.get(context).messages.isNotEmpty,
                            builder: (context) => Expanded(
                                  child: ListView.separated(
                                    physics: const BouncingScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      var message = SocialCubit.get(context)
                                          .messages[index];

                                      if (SocialCubit.get(context)
                                              .userModel
                                              .uId ==
                                          message.senderId) {
                                        return buildMyMessage(message);
                                      } else {
                                        return buildMessage(message);
                                      }
                                    },
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(height: 10),
                                    itemCount: SocialCubit.get(context)
                                        .messages
                                        .length,
                                  ),
                                ),
                            fallback: (context) => Expanded(
                                    child: Column(children: const [
                                  Spacer(),
                                  Center(
                                      child: Text('Start Chat...',
                                          style: TextStyle(fontSize: 20))),
                                  Spacer(),
                                ]))),
                        Column(
                          children: [
                            const SizedBox(height: 6),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.blueGrey),
                                  borderRadius: BorderRadius.circular(15.0)),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: Row(
                                children: [
                                  const SizedBox(width: 10),
                                  Expanded(
                                      child: TextFormField(
                                    controller: messageController,
                                    onFieldSubmitted: (value) {
                                      if (messageController.text != '') {
                                        SocialCubit.get(context).sendMessage(
                                          receiverId: userModel.uId,
                                          dateTime: now.toString(),
                                          time: DateTime.now().toString(),
                                          text: value,
                                        );
                                        HapticFeedback.vibrate();
                                        messageController.clear();
                                      }
                                    },
                                    decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Type your message here..'),
                                  )),
                                  Container(
                                    color: Colors.blueGrey,
                                    height: 50,
                                    child: MaterialButton(
                                      onLongPress: () =>
                                          HapticFeedback.vibrate(),
                                      onPressed: () {
                                        if (messageController.text != '') {
                                          SocialCubit.get(context).sendMessage(
                                            receiverId: userModel.uId,
                                            dateTime: now.toString(),
                                            time: DateTime.now().toString(),
                                            text: messageController.text,
                                          );
                                          HapticFeedback.vibrate();
                                          messageController.clear();
                                        }
                                      },
                                      minWidth: 1.0,
                                      child: const Icon(
                                        IconBroken.Send,
                                        size: 20.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ));
        },
      );
    });
  }

  Widget buildMessage(MessageModel messageModel) => Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: const BorderRadiusDirectional.only(
                  topStart: Radius.circular(10),
                  topEnd: Radius.circular(10),
                  bottomEnd: Radius.circular(10))),
          child:
              Text(messageModel.text, style: const TextStyle(fontSize: 18))));

  Widget buildMyMessage(MessageModel messageModel) => Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
              color: Colors.blueGrey.withOpacity(0.2),
              borderRadius: const BorderRadiusDirectional.only(
                topStart: Radius.circular(10),
                topEnd: Radius.circular(10),
                bottomStart: Radius.circular(10),
              )),
          child:
              Text(messageModel.text, style: const TextStyle(fontSize: 18))));
}

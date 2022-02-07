import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:social_application/chats/chat_details_screen.dart';
import 'package:social_application/friends/profile_details_screen.dart';
import 'package:social_application/models/user_model.dart';

String? uId = '';
File? coverImage;
File? profileImage;

String? token = '';
bool? firstTime = true;

var now = DateFormat.yMEd().add_jm().format(DateTime.now());

navigateTo(context, widget) {
  return Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => widget),
  );
}

navigateAndFinish(context, widget) {
  return Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context) => widget),
    (route) => false,
  );
}

Widget myDivider() => Column(
      children: [
        const SizedBox(height: 5),
        Container(
          height: 2.0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0), color: Colors.red),
        ),
      ],
    );

Widget buildProfileItem(
  SocialUserModel model,
  context, {
  isChat = false,
}) =>
    InkWell(
      onTap: () {
        if (isChat) {
          navigateTo(context, ChatDetailsScreen(userModel: model));
        } else {
          navigateTo(context, ProfileDetailsScreen(userModel: model));
        }
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

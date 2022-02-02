import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String uId = '';
String token = '';
bool firstTime = true;

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

void printFullText(String text) {
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern
      .allMatches(text)
      .forEach((match) => debugPrint(match.group(0).toString()));
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

import 'package:dio/dio.dart';

var postUrl = "https://fcm.googleapis.com/fcm/send";

final headers = {
  'Content-Type': 'application/json',
  'Authorization':
      'key=AAAAoi5ftxc:APA91bF4Jpaqg3LSm_mhanRRRBryTVY9vfzashPTVjxdslWAglD0El11C_Eo62FaGRRGr8gC_BhtvN6HEvyPgTgjrU9CyD95z69vLRrRAutKZXFx0V0f48LMFDIrdg5bYtflQGM49yAA',
};

Future<void> messageNotification({
  receiverToken,
  sender,
  message,
}) async {
  var dio = Dio(BaseOptions(receiveDataWhenStatusError: true));
  await dio
      .post(
    postUrl,
    data: {
      "to": receiverToken,
      "notification": {"title": sender, "body": message},
      "android": {
        "priority": "HIGH",
        "notification": {
          "notification_priority": "PRIORITY_MAX",
          "sound": "default",
          "default_sound": true,
          "default_vibrate_timings": true,
          "default_light_settings": true
        }
      },
      "data": {
        "id": "1",
        "name": "mohamed",
        "click_action": "FLUTTER_NOTIFICATION_CLICK"
      }
    },
    options: Options(headers: headers),
  )
      .then((value) {
    // debugPrint(receiverToken);
    //debugPrint(sender);
    // debugPrint(message);

    //debugPrint('value ' + value.data.toString());
  });
}

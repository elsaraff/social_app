class FcmDataModel {
  late String to;
  late Notification notification;
  late Android android;
  late Data data;

  FcmDataModel.fromJson(Map<String, dynamic> json) {
    to = json['to'];
    notification = Notification.fromJson(json['notification']);
    android = Android.fromJson(json['android']);
    data = Data.fromJson(json['data']);
  }
}

class Notification {
  late String title;
   late String body;

  Notification.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    body = json['body'];
  }
}

class Android {
  late String priority;
  late AndroidNotification notification;

  Android.fromJson(Map<String, dynamic> json) {
    priority = json['priority'];
    notification = AndroidNotification.fromJson(json['notification']);
  }
}

class AndroidNotification {
  late String notificationPriority;
  late String sound;
  late bool defaultSound;
  late bool defaultVibrateTimings;
  late bool defaultLightSettings;

  AndroidNotification.fromJson(Map<String, dynamic> json) {
    notificationPriority = json['notification_priority'];
    sound = json['sound'];
    defaultSound = json['default_sound'];
    defaultVibrateTimings = json['default_vibrate_timings'];
    defaultLightSettings = json['default_light_settings'];
  }
}

class Data {
  late String id;
  late String name;
  late String clickAction;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    clickAction = json['click_action'];
  }
}

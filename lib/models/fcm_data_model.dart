class FcmDataModel {
  String to;
  Notification notification;
  Android android;
  Data data;

  FcmDataModel.fromJson(Map<String, dynamic> json) {
    to = json['to'];
    notification = Notification.fromJson(json['notification']);
    android = Android.fromJson(json['android']);
    data = Data.fromJson(json['data']);
  }
}

class Notification {
  String title;
  String body;

  Notification.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    body = json['body'];
  }
}

class Android {
  String priority;
  AndroidNotification notification;

  Android.fromJson(Map<String, dynamic> json) {
    priority = json['priority'];
    notification = AndroidNotification.fromJson(json['notification']);
  }
}

class AndroidNotification {
  String notificationPriority;
  String sound;
  bool defaultSound;
  bool defaultVibrateTimings;
  bool defaultLightSettings;

  AndroidNotification.fromJson(Map<String, dynamic> json) {
    notificationPriority = json['notification_priority'];
    sound = json['sound'];
    defaultSound = json['default_sound'];
    defaultVibrateTimings = json['default_vibrate_timings'];
    defaultLightSettings = json['default_light_settings'];
  }
}

class Data {
  String id;
  String name;
  String clickAction;

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    clickAction = json['click_action'];
  }
}

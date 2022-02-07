class MessageModel {
  late String senderId;
  late String receiverId;
  late String dateTime;
  late String time;
  late String text;

  MessageModel({
    required this.senderId,
    required this.receiverId,
    required this.dateTime,
    required this.time,
    required this.text,
  });

  MessageModel.fromJson(Map<String, dynamic> json) {
    senderId = json['senderId'];
    receiverId = json['receiverId'];
    dateTime = json['dateTime'];
    time = json['time'];
    text = json['text'];
  }

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'dateTime': dateTime,
      'time': time,
      'text': text,
    };
  }
}

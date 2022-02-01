class MessageModel {
  String senderId;
  String receiverId;
  String dateTime;
  String time;
  String text;

  MessageModel({
    this.senderId,
    this.receiverId,
    this.dateTime,
    this.time,
    this.text,
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

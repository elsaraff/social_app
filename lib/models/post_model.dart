class PostModel {
  String name;
  String uId;
  String image;
  String dateTime;
  String time;
  String text;
  String postImage;

  PostModel({
    this.name,
    this.uId,
    this.image,
    this.dateTime,
    this.time,
    this.text,
    this.postImage,
  });

  PostModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    uId = json['uId'];
    image = json['image'];
    dateTime = json['dateTime'];
    time = json['time'];
    text = json['text'];
    postImage = json['postImage'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uId': uId,
      'image': image,
      'dateTime': dateTime,
      'time': time,
      'text': text,
      'postImage': postImage,
    };
  }
}

class CommentModel {
  late String postId;
  late String uId;
  late String name;
  late String image;
  late String comment;
  late String dateTime;
  late String time;

  CommentModel({
    required this.comment,
    required this.name,
    required this.image,
    required this.dateTime,
    required this.time,
    required this.uId,
    required this.postId,
  });

  CommentModel.fromJson(Map<String, dynamic> json) {
    dateTime = json['dateTime'];
    time = json['time'];
    comment = json['comment'];
    uId = json['uId'];
    image = json['image'];
    name = json['name'];
    postId = json['postId'];
  }

  Map<String, dynamic> toMap() {
    return {
      'dateTime': dateTime,
      'time': time,
      'comment': comment,
      'uId': uId,
      'image': image,
      'name': name,
      'postId': postId,
    };
  }
}

class CommentModel {
  String postId;
  String uId;
  String name;
  String image;
  String comment;
  String dateTime;
  String time;
  String commentId;

  CommentModel({
    this.comment,
    this.commentId,
    this.name,
    this.image,
    this.dateTime,
    this.time,
    this.uId,
    this.postId,
  });

  CommentModel.fromJson(Map<String, dynamic> json) {
    dateTime = json['dateTime'];
    time = json['time'];
    comment = json['comment'];
    uId = json['uId'];
    image = json['image'];
    name = json['name'];
    postId = json['postId'];
    commentId = json['commentId'];
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
      'commentId': commentId,
    };
  }
}

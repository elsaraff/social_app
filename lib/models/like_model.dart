class LikeModel {
  String postId;
  String uId;
  String name;
  String image;
  bool like;
  String time;

  LikeModel({
    this.name,
    this.image,
    this.uId,
    this.postId,
    this.like,
    this.time,
  });

  LikeModel.fromJson(Map<String, dynamic> json) {
    uId = json['uId'];
    image = json['image'];
    name = json['name'];
    postId = json['postId'];
    like = json['like'];
    time = json['time'];
  }

  Map<String, dynamic> toMap() {
    return {
      'uId': uId,
      'image': image,
      'name': name,
      'postId': postId,
      'like': like,
      'time': time,
    };
  }
}

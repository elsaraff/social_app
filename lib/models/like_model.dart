class LikeModel {
  late String postId;
  late String uId;
  late  String name;
  late  String image;
  late  bool like;
  late  String time;

  LikeModel({
    required this.name,
    required this.image,
    required this.uId,
    required this.postId,
    required this.like,
    required this.time,
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

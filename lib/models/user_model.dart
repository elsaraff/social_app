class SocialUserModel {
  late String name;
  late String email;
  late String phone;
  late String bio;
  late String uId;
  late String image;
  late String cover;
  late bool announcement;

  SocialUserModel(
      {required this.name,
      required this.email,
      required this.phone,
      required this.bio,
      required this.uId,
      required this.image,
      required this.cover,
      required this.announcement});

  SocialUserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    bio = json['bio'];
    uId = json['uId'];
    image = json['image'];
    cover = json['cover'];
    announcement = json['announcement'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'bio': bio,
      'uId': uId,
      'image': image,
      'cover': cover,
      'announcement': announcement,
    };
  }
}

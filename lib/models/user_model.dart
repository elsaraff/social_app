class SocialUserModel {
  String name;
  String email;
  String phone;
  String bio;
  String uId;
  String image;
  String cover;
  bool announcement;

  SocialUserModel(
      {this.name,
      this.email,
      this.phone,
      this.bio,
      this.uId,
      this.image,
      this.cover,
      this.announcement});

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

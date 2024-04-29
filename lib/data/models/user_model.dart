class UserModel {
  final String uid;
  final String email;
  final String username;
  final String? nickname;
  final String? password;

  UserModel({
    required this.uid,
    required this.email,
    required this.username,
    required this.nickname,
    this.password
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    uid: json['uid'],
        email: json['email'],
        username: json['username'],
        nickname: json['nickname'],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "email": email,
        "username": username,
        "nickname": nickname,
      };
}

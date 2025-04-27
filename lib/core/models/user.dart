class UserModel {
  final String uid;
  final String email;
  final String name;
  final String token;

  UserModel({
    required this.uid,
    required this.email,
    required this.name,
    required this.token,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      token: map['token'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'token': token,
    };
  }
}

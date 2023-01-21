import 'dart:convert';

class UserModel {
  factory UserModel.fromJson(String json) =>
      UserModel.fromMap(jsonDecode(json));

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(name: map['name'], photoURL: map['photoURL']);
  }

  UserModel({required this.name, this.photoURL});
  final String name;
  final String? photoURL;

  Map<String, dynamic> toMap() => {
        'name': name,
        'photoURL': photoURL,
      };

  String toJson() => jsonEncode(toMap());
}

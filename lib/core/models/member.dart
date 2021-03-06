import 'dart:convert';

class Member {
  final String id;
  final String name;
  final String gender;
  final String phoneNumber;
  final String avatarImage;
  final List<String> group;

  Member({this.gender = '', this.id = '', this.name = '', this.phoneNumber = '', this.avatarImage = '', required this.group});

  Member.Initial() : id = '', name='', gender='', phoneNumber='', avatarImage='', group = [];

  Member copyWith({
    required String name,
    required String phoneNumber,
    required String avatarImage,
    required String gender,
    required List<String> group,
  }) {
    return Member(
      id: this.id,
      name: name == null ? this.name : name,
      phoneNumber: phoneNumber == null ? this.phoneNumber : phoneNumber,
      avatarImage: avatarImage == null ? this.avatarImage : avatarImage,
      group: group == null ? group : this.group,
      gender: gender == null ? this.gender : gender,
    );
  }

  factory Member.fromJson(Map<String, dynamic> json) =>
      Member(id: json['id'], group: json['group'].cast<String>(), name: json['name'], phoneNumber: json['phoneNumber'], avatarImage: json['avatarImage'], gender: json['gender']);

  // factory Member.fromJson(dynamic json) =>
  //     Member(group: json['group'] as List<String>, name: json['name'] as String, phoneNumber: json['phoneNumber'] as String, avatarImage: json['avatarImage'] as String);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'gender': gender,
      'phoneNumber': phoneNumber,
      'avatarImage': avatarImage,
      'group': group
    };
  }

  String toJson() => json.encode(toMap());

}
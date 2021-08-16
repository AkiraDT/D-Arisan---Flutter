import 'dart:convert';

class Member {
  final String name;
  final String phoneNumber;
  final String avatarImage;
  final List<String> group;

  Member({this.name = '', this.phoneNumber = '', this.avatarImage = '', required this.group});

  Member.Initial() : name='', phoneNumber='', avatarImage='', group = [];

  Member copyWith({
    String name = '',
    String phoneNumber='',
    String avatarImage='',
    required List<String> group,
  }) {
    return Member(
      name: name == '' ? this.name : name,
      phoneNumber: phoneNumber == '' ? this.phoneNumber : phoneNumber,
      avatarImage: avatarImage == '' ? this.avatarImage : avatarImage,
      group: group ?? this.group,
    );
  }

  factory Member.fromJson(Map<String, dynamic> json) =>
      Member(group: json['group'].cast<String>(), name: json['name'], phoneNumber: json['phoneNumber'], avatarImage: json['avatarImage']);

  // factory Member.fromJson(dynamic json) =>
  //     Member(group: json['group'] as List<String>, name: json['name'] as String, phoneNumber: json['phoneNumber'] as String, avatarImage: json['avatarImage'] as String);

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phoneNumber': phoneNumber,
      'avatarImage': avatarImage,
      'group': group
    };
  }

  String toJson() => json.encode(toMap());

}
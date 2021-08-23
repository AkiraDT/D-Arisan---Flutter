import 'dart:convert';

class Group {
  final String id;
  final String name;
  final int wage;
  final List<String> members;
  final bool isStarted;
  final bool isEnded;
  final String groupImage;

  Group({required this.id, required this.name, required this.wage, required this.members, required this.isStarted, required this.isEnded, required this.groupImage, });

  Group.Initial() : id = '', name='', wage=0, isStarted=false, isEnded=false, groupImage='', members=[];

  Group copyWith({
    required String name,
    required int wage,
    required bool isStarted,
    required bool isEnded,
    required String groupImage,
    required List<String> members,
  }) {
    return Group(
      id: this.id,
      name: name == null ? this.name : name,
      wage: wage == null ? this.wage : wage,
      isStarted: isStarted == null ? this.isStarted : isStarted,
      isEnded: isEnded == null ? isEnded : this.isEnded,
      groupImage: groupImage == null ? this.groupImage : groupImage,
      members: members == null ? this.members : members,
    );
  }

  factory Group.fromJson(Map<String, dynamic> json) =>
      Group(id: json['id'], isEnded: json['isEnded'], name: json['name'], groupImage: json['groupImage'], wage: json['wage'], members: json['members'].cast<String>(), isStarted: json['isStarted'], );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'wage': wage,
      'isStarted': isStarted,
      'isEnded': isEnded,
      'groupImage': groupImage,
      'members': members,
    };
  }

  String toJson() => json.encode(toMap());
}
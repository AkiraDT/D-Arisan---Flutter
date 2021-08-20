import 'dart:io';

import 'package:darisan/core/models/member.dart';
import 'package:darisan/member/widget/member_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MemberCard extends StatelessWidget{
  final Member memberData;

  const MemberCard({Key? key, required this.memberData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        child: InkWell(
          onTap: () => showDialog(
              context: context,
              builder: (BuildContext context) {
                return MemberDetail(
                    name: memberData.name,
                    gender: memberData.gender,
                    phoneNumber: memberData.phoneNumber,
                    avatarImage: memberData.avatarImage,
                    group: memberData.group
                );
              }),
          onLongPress: () => Navigator.pushNamed(context, '/editMember', arguments: memberData.id),
          child: Row(
            children: [
              CircleAvatar(
                radius: 35,
                backgroundImage: this.memberData.avatarImage.contains('assets/images') ? AssetImage(this.memberData.avatarImage) as ImageProvider : FileImage(new File(this.memberData.avatarImage)),
              ),
              Container(
                  margin: EdgeInsets.only(left: 10),
                  child:
                  IntrinsicWidth(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(this.memberData.name, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),),
                        Container(
                          margin: EdgeInsets.only(top: 2, bottom: 6),
                          color: Colors.black26, height: 0.5, width: 300,),
                        Text(this.memberData.phoneNumber, style: TextStyle(fontSize: 10, color: Colors.black54),),
                      ],),
                  )
              )
            ],
          ),
        )
    );
  }

}

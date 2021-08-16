import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MemberCard extends StatelessWidget{
  final String name;
  final String phoneNumber;
  final String avatarImage;

  const MemberCard({Key? key, required this.name, this.phoneNumber = '', required this.avatarImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        child: Row(
          children: [
            CircleAvatar(
              radius: 35,
              backgroundImage: FileImage(new File(this.avatarImage)),
            ),
            Container(
              margin: EdgeInsets.only(left: 10),
              child:
              IntrinsicWidth(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Text(this.name, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),),
                  Container(
                    margin: EdgeInsets.only(top: 2, bottom: 6),
                    color: Colors.black26, height: 0.5, width: 300,),
                  Text(this.phoneNumber, style: TextStyle(fontSize: 10, color: Colors.black54),),
                ],),
              )
            )
          ],
        )
    );
  }

}

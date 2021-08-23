import 'dart:io';

import 'package:darisan/core/models/group.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GroupCard extends StatelessWidget{
  final Group groupData;

  const GroupCard({Key? key, required this.groupData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        child: InkWell(
          onTap: () => print('yeah'),
          onLongPress: () => print('yeahLong'),
          child: Row(
            children: [
              CircleAvatar(
                radius: 35,
                backgroundImage: this.groupData.groupImage.contains('assets/images') ? AssetImage(this.groupData.groupImage) as ImageProvider : FileImage(new File(this.groupData.groupImage)),
              ),
              Container(
                  margin: EdgeInsets.only(left: 10),
                  child:
                  IntrinsicWidth(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(this.groupData.name, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),),
                        Container(
                          margin: EdgeInsets.only(top: 2, bottom: 6),
                          color: Colors.black26, height: 0.5, width: 300,),
                        Text(this.groupData.wage.toString(), style: TextStyle(fontSize: 10, color: Colors.black54),),
                      ],),
                  )
              )
            ],
          ),
        )
    );
  }

}

import 'dart:io';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MemberDetail extends StatelessWidget {
  final String name;
  final String gender;
  final String phoneNumber;
  final String avatarImage;
  final List<String> group;

  MemberDetail({
    Key? key,
    required this.name,
    required this.gender,
    required this.phoneNumber,
    required this.avatarImage,
    required this.group,
  }) : super(key: key);

  List<Widget> chipBuilder() {
    return this.group.map((e) =>
        Chip(
          label: Text(e.toString()),
        )).toList();
  }

  @override
  Widget build(BuildContext context) {

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Container(
        width: 400,
        height: 450,
        margin: EdgeInsets.only(top: 50),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: this.gender == 'Female' ? Colors.pinkAccent : Theme.of(context).buttonColor, width: 3),
            boxShadow: [
              BoxShadow(
                  color: Colors.black38, offset: Offset(0, 10), blurRadius: 10),
            ]),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              height: 110,
              width: double.infinity,
              // color: Colors.blue,
              child: Image.asset(
                this.gender == 'Female' ? 'assets/images/female_bg.png' : 'assets/images/male_bg.png',
                fit: BoxFit.cover,
              ),
            ),
            Column(
              // mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 40),
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage: this.avatarImage.contains('assets/images') ? AssetImage(this.avatarImage) as ImageProvider : FileImage(new File(this.avatarImage)),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 24),
                  child: Text(
                    this.name,
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: this.gender == 'Female' ? Colors.pinkAccent : Colors.blueAccent),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Text(
                    this.gender,
                    style: TextStyle(fontSize: 16, color: this.gender == 'Female' ? Colors.pink : Colors.lightBlue),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Text(
                    this.phoneNumber,
                    style: TextStyle(fontSize: 16, color: this.gender == 'Female' ? Colors.pink :  Colors.lightBlue),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5),
                  height: 140,
                  child: SingleChildScrollView(
                    child: Wrap(
                      spacing: 2.0, // gap between adjacent chips
                      children: chipBuilder(),
                    ),
                  ),
                )
              ],
            ),
          ],
        ));
  }
}

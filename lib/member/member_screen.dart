import 'package:darisan/core/widget/main_app_bar.dart';
import 'package:darisan/member/widget/member_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MemberScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar('Member'),
      body: Container(
        margin: EdgeInsets.all(5),
        height: double.infinity,
        width: double.infinity,
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: 20,
            itemBuilder: (context, index) {
              return MemberCard();
            }
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/addMember'),
        tooltip: 'Add Member',
        child: Icon(Icons.add, color: Colors.white,),
        backgroundColor: Theme.of(context).buttonColor,
      ),
    );
  }

}
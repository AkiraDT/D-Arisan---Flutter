import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MemberCard extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        child: Row(
          children: [
            CircleAvatar(
              radius: 35,
              backgroundImage: NetworkImage('https://static.wikia.nocookie.net/haikyuu/images/d/d2/Hinata_s4-e1-4.png/revision/latest?cb=20200506183149'),
            ),
            Container(
              margin: EdgeInsets.only(left: 10),
              child:
              IntrinsicWidth(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Text('Hinata Shouto', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),),
                  Container(
                    margin: EdgeInsets.only(top: 2, bottom: 6),
                    color: Colors.black26, height: 0.5, width: 300,),
                  Text('Midle Blocker', style: TextStyle(fontSize: 10, color: Colors.black54),),
                ],),
              )
            )
          ],
        )
    );
  }

}

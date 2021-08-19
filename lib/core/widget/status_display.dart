import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class StatusDisplay extends StatelessWidget {
  final String message, detail;
  final bool isSucces;

  const StatusDisplay({Key? key, this.message = 'Message', this.detail = 'Message detail', this.isSucces = false}) : super(key: key);

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
  contentBox(context){
    return Stack(
      children: [
        Container(
          height: 235,
          width: 400,
          margin: EdgeInsets.only(top: 50),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Theme.of(context).buttonColor, width: 5),
              boxShadow: [
                BoxShadow(color: Colors.black38,offset: Offset(0,10),
                    blurRadius: 10
                ),
              ]
          ),
          child: Column(
            // mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: EdgeInsets.only(top: 32),
                child: ClipOval(
                  child: Container(
                      height: 60,
                      width: 60,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.asset(this.isSucces ? 'assets/images/success_bg.png' : 'assets/images/failed_bg.png'),
                          Image.asset(this.isSucces ? 'assets/images/success.png' : 'assets/images/failed.png'),
                        ],
                      )
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 24),
                child: Text(this.message,style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold, color: Colors.blueAccent),),
              ),
              Container(
                margin: EdgeInsets.only(top: 10, bottom: 20),
                child: Text(this.detail,style: TextStyle(fontSize: 16, color: Colors.lightBlue),textAlign: TextAlign.center,overflow: TextOverflow.ellipsis,maxLines: 3,),
              )
            ],
          ),
        ),
        // Positioned(
        //   left: 30,
        //   right: 30,
        //   child: CircleAvatar(
        //     backgroundColor: Colors.transparent,
        //     radius: 50,
        //     child: ClipRRect(
        //         borderRadius: BorderRadius.all(Radius.circular(50)),
        //         child: Image.network(
        //           'https://static.wikia.nocookie.net/haikyuu/images/d/d2/Hinata_s4-e1-4.png/revision/latest?cb=20200506183149',
        //           fit: BoxFit.cover,)
        //     ),
        //   ),
        // ),
      ],
    );
  }
}

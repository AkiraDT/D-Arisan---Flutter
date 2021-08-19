import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingCircle extends StatelessWidget{
  final double height;
  final double width;

  const LoadingCircle({Key? key, this.height = 0, this.width = 0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.black26,
      width: this.width == 0 ? MediaQuery.of(context).size.width : this.width,
      height: this.height == 0 ? MediaQuery.of(context).size.height : this.height,
      alignment: Alignment.center,
      child: Container(
        width: 70,
        height: 70,
        child: CircularProgressIndicator(color: Theme.of(context).buttonColor,strokeWidth: 8,),
      ),
    );
  }

}
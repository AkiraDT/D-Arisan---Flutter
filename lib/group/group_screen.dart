import 'package:darisan/core/widget/main_app_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GroupScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar('Group'),
      body: Center(child: Text('Group'),),
    );
  }
  
}
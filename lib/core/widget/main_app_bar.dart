import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget{
  final toolbarHeight;
  final bottom;
  String title;

  MainAppBar(this.title, {Key? key, this.toolbarHeight, this.bottom}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(this.title, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(toolbarHeight ?? kToolbarHeight + (bottom?.preferredSize.height ?? 0.0));

}
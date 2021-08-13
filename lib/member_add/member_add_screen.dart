import 'dart:io';

import 'package:darisan/core/widget/main_app_bar.dart';
import 'package:darisan/member_add/widget/input_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class MemberAddScreen extends StatefulWidget{
  @override
  State<MemberAddScreen> createState() {
    return MemberAddScreenState();
  }

}

class MemberAddScreenState extends State<MemberAddScreen>{
  XFile _image = new XFile('');
  final ImagePicker _picker = ImagePicker();

  Future getImage(ImageSource media) async {
    XFile? img = await _picker.pickImage(source: media);
    setState(() {
      _image = img!;
    });
  }

  void myAlert() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: Text('Please choose media to select'),
            content: Container(
              height: MediaQuery.of(context).size.height / 6,
              child: Column(
                children: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.gallery);
                    },
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.image),
                        Text('From Gallery'),
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.camera);
                    },
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.camera),
                        Text('From Camera'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar('Add Member'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                height: 200,
                child: Container(
                  alignment: Alignment.center,
                  child:
                  // ClipOval(
                  //     child: Container(
                  //       height: 150,
                  //       width: 150,
                  //       padding: EdgeInsets.all(25),
                  //       color: Colors.blueGrey,
                  //       child: Image(
                  //         image: AssetImage('assets/images/add_picture.png'),
                  //       ),
                  //     )),
                  Column(
                    children: <Widget>[
                      Padding(
                        padding:
                        const EdgeInsets.only(left: 16, top: 16, right: 16),
                        child:GestureDetector(
                          onTap: () {
                            myAlert();
                          },
                          child: Container(
                            height: 150,
                            width: 150,
                            child: CircleAvatar(
                              radius: 150,
                              backgroundImage: _image.path == '' ? 
                              AssetImage('assets/images/add_picture.png') :
                              FileImage(new File(_image.path)) as ImageProvider,
                              // Image.file(
                              //   new File(_image.path),
                              //   fit: BoxFit.cover,
                              // ),
                            ),
                          ),
                        )
                      ),
                    ],
                  ),
                )),
            Container(
                height: 430,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: [
                      Column(
                        children: [
                          InputField(
                            label: 'USER NAME',
                            icon: Icons.person_outline,
                            onChanged: (val) => print(val),
                          ),
                          InputField(
                            label: 'PASSWORD',
                            icon: Icons.lock_outline,
                            isPassword: true,
                            onChanged: (val) => print(val),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 30),
                        alignment: Alignment.center,
                        child: InkWell(
                              onTap: () {
                                // Navigator.pushReplacementNamed(context, '/main');
                              },
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: Theme.of(context).buttonColor,
                                ),
                                height: 50,
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 8),
                                child: Text("Add Member",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white)),
                              )),
                      ),
                    ],
                  ),
                )),
           ],
        ),
      ));
  }

}
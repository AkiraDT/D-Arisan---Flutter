import 'dart:io';

import 'package:darisan/core/common/async_state.dart';
import 'package:darisan/core/widget/loading_circle.dart';
import 'package:darisan/core/widget/status_display.dart';
import 'package:darisan/member/member_view_model.dart';
import 'package:darisan/member_add/member_add_view_model.dart';
import 'package:darisan/member_add/widget/input_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class MemberAddScreen extends StatelessWidget {
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    Future getImage(ImageSource media) async {
      XFile? img = await _picker.pickImage(source: media);
      context
          .read(memberAddViewModelProvider.notifier)
          .setState(img!.path, 'avatar');
    }

    void pictureOption() {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              title: Text('Please choose media to select'),
              content: Container(
                height: MediaQuery.of(context).size.height / 8,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                      iconSize: 60,
                      icon: Icon(
                        Icons.camera_alt_outlined,
                        color: Theme.of(context).buttonColor,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        getImage(ImageSource.camera);
                      },
                    ),
                    VerticalDivider(
                      width: 30,
                    ),
                    IconButton(
                      iconSize: 60,
                      icon: Icon(Icons.folder_open,
                          color: Theme.of(context).buttonColor),
                      onPressed: () {
                        Navigator.pop(context);
                        getImage(ImageSource.gallery);
                      },
                    ),
                  ],
                ),
              ),
            );
          });
    }

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text('Add Member',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
        body: SingleChildScrollView(
            child: Stack(
          children: [
            Column(
              children: [
                Container(
                    height: 200,
                    child: Container(
                      alignment: Alignment.center,
                      child: Column(
                        children: <Widget>[
                          Padding(
                              padding: const EdgeInsets.only(
                                  left: 16, top: 16, right: 16),
                              child: GestureDetector(
                                onTap: () {
                                  pictureOption();
                                },
                                child: Container(
                                  height: 150,
                                  width: 150,
                                  child: Consumer(
                                    builder: (context, watch, widget) {
                                      final state =
                                          watch(memberAddViewModelProvider);
                                      return state.data.avatarImage == ''
                                          ? Material(
                                              child: CircleAvatar(
                                                  radius: 150,
                                                  backgroundImage: AssetImage(
                                                      'assets/images/add_picture.png')),
                                            )
                                          : Material(
                                              child: CircleAvatar(
                                                  radius: 150,
                                                  backgroundImage: FileImage(
                                                          new File(state.data
                                                              .avatarImage))
                                                      as ImageProvider));
                                    },
                                  ),
                                ),
                              )),
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
                                label: 'Username',
                                icon: Icons.person_outline,
                                onChanged: (val) => context
                                    .read(memberAddViewModelProvider.notifier)
                                    .setState(val, 'name'),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 30),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Gender', style: TextStyle(color: Colors.black54,fontSize: 14),),
                                    Consumer(builder: (context, watch, widget) {
                                      final state = watch(memberAddViewModelProvider);
                                      return Container(
                                        child: Row(
                                          children: [
                                            Expanded(child: ListTile(
                                              title: Text("Male"),
                                              leading: Radio(
                                                value: 'Male',
                                                groupValue: state.data.gender,
                                                onChanged: (val) {
                                                  context.read(memberAddViewModelProvider.notifier).setState(val.toString(), 'gender');
                                                },
                                                activeColor: Theme.of(context).buttonColor,
                                              ),
                                            ),),
                                            Expanded(child: ListTile(
                                              title: Text("Female"),
                                              leading: Radio(
                                                value: 'Female',
                                                groupValue: state.data.gender,
                                                onChanged: (val) {
                                                  context.read(memberAddViewModelProvider.notifier).setState(val.toString(), 'gender');
                                                },
                                                activeColor: Theme.of(context).buttonColor,
                                              ),
                                            ),),
                                          ],
                                        ),
                                      );
                                    })
                                  ],
                                ),
                              ),
                              InputField(
                                label: 'Phone Number',
                                icon: Icons.lock_outline,
                                onChanged: (val) => context
                                    .read(memberAddViewModelProvider.notifier)
                                    .setState(val, 'phone'),
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 30),
                            alignment: Alignment.center,
                            child: InkWell(
                                onTap: () {
                                  context
                                      .read(memberAddViewModelProvider.notifier)
                                      .saveData(context
                                          .read(memberAddViewModelProvider)
                                          .data);
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
            Consumer(builder: (context, watch, widget) {
              final state = watch(memberAddViewModelProvider);
              if (state is Loading) {
                return LoadingCircle();
              } else if (state is Success || state is Error) {
                WidgetsBinding.instance!.addPostFrameCallback((_) {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return StatusDisplay(
                          isSucces: state is Success ? true : false,
                          message: state is Success ? 'Success!' : 'Error!',
                          detail: state is Success
                              ? '${state.data.name} was Added!'
                              : (state as Error).error,
                        );
                      }).then((value) {
                    if (state is Success) {
                      Navigator.pop(context);
                      context.read(memberViewModelProvider.notifier).loadData();
                    } else {}
                  });
                });
                return SizedBox.shrink();
              } else {
                return SizedBox.shrink();
              }
            })
          ],
        )));
  }
}

import 'dart:io';

import 'package:darisan/core/common/async_state.dart';
import 'package:darisan/core/common/constant.dart';
import 'package:darisan/core/widget/loading_circle.dart';
import 'package:darisan/core/widget/status_display.dart';
import 'package:darisan/core/widget/input_field.dart';
import 'package:darisan/group/group_view_model.dart';
import 'package:darisan/group_add/group_add_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class GroupAddScreen extends StatelessWidget {
  final ImagePicker _picker = ImagePicker();
  final bool isEdit;

  GroupAddScreen({Key? key, this.isEdit = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future getImage(ImageSource media) async {
      XFile? img = await _picker.pickImage(source: media);
      context
          .read(groupAddViewModelProvider.notifier)
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

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      String id = ModalRoute.of(context)!.settings.arguments as String;
      if (this.isEdit) {
        context.read(groupAddViewModelProvider.notifier).loadData(id);
      }
    });

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
          title: Text(this.isEdit ? 'Edit Member' : 'Add Member',
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
                                          watch(groupAddViewModelProvider);
                                      return state.data.groupImage == ''
                                          ? Material(
                                              color: Colors.transparent,
                                              child: CircleAvatar(
                                                  radius: 150,
                                                  backgroundImage: AssetImage(
                                                      PICTURE_ADD_PATH)),
                                            )
                                          : Material(
                                              color: Colors.transparent,
                                              child: CircleAvatar(
                                                  radius: 150,
                                                  backgroundImage: FileImage(
                                                          new File(state.data
                                                              .groupImage))
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
                              Consumer(
                                builder: (context, watch, child) {
                                  final state =
                                      watch(groupAddViewModelProvider);
                                  return InputField(
                                    value: state.data.name,
                                    label: 'Group Name',
                                    icon: Icons.person_outline,
                                    onChanged: (val) => context
                                        .read(
                                            groupAddViewModelProvider.notifier)
                                        .setState(val, 'name'),
                                  );
                                },
                              ),
                              Consumer(builder: (context, watch, child) {
                                final state = watch(groupAddViewModelProvider);
                                return InputField(
                                  value: state.data.wage.toString(),
                                  label: 'Wage',
                                  textInputType: TextInputType.number,
                                  icon: Icons.lock_outline,
                                  onChanged: (val) => context
                                      .read(groupAddViewModelProvider.notifier)
                                      .setState(val, 'phone'),
                                );
                              }),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 30),
                            alignment: Alignment.center,
                            child: InkWell(
                                onTap: () {
                                  context.read(groupAddViewModelProvider.notifier).saveData(context.read(groupAddViewModelProvider).data, this.isEdit);
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
                                  child: Text(this.isEdit ? 'Update Member' : "Add Member",
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
              final state = watch(groupAddViewModelProvider);
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
                              ? '${state.data.name} was ${this.isEdit ? 'Updated' : 'Added'}!'
                              : (state as Error).error,
                        );
                      }).then((value) {
                    if (state is Success) {
                      Navigator.pop(context);
                      context.read(groupViewModelProvider.notifier).loadData();
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

import 'dart:convert';

import 'package:darisan/core/common/async_state.dart';
import 'package:darisan/core/common/keys.dart';
import 'package:darisan/core/models/group.dart';
import 'package:darisan/core/providers/storage_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:uuid/uuid.dart';


final groupAddViewModelProvider =
StateNotifierProvider.autoDispose<GroupAddViewModel, AsyncState<Group>>(
        (ref) => GroupAddViewModel(ref.read(storageProvider)));

class GroupAddViewModel extends StateNotifier<AsyncState<Group>> {
  final FlutterSecureStorage _storage;

  GroupAddViewModel(this._storage) : super( Initial(new Group.Initial()));

  void setState(String val, String field) {
    // state = Loading(state.data);
    try{
      switch(field){
        case 'name':
          // state = Initial(state.data.copyWith());
          break;
      }

    }catch(exception){
      print('Something Went Wrong with Form Member Add: ${exception}');
      state = Error(exception.toString(), state.data);
    }
  }

  void saveData(Group data, bool isEdit) async {
    state = Loading(state.data);
    try{
      var storageData = await _storage.read(key: KEY_MEMBER);
      var uuid = Uuid();
      String imagePath = '';
      if (data.groupImage == '') {
        imagePath = 'assets/images/def_girl1.png';
      } else {
        imagePath = data.groupImage;
      }

      if (storageData == null) {
        if (isEdit) {
          throw new Exception('No Data to Update!');
        }
        List<Group> listData = [];
        // listData.add(new Group(id: uuid.v4(), name: data.name, gender: data.gender, phoneNumber: data.phoneNumber, avatarImage: imagePath, group: data.group));
        await saveDataToStorage(listData, KEY_GROUP);
        state = Success(state.data);
      } else {
        var listString = List.from(jsonDecode(storageData));
        List<Group> listData = listString.map((dat) => new Group.fromJson(jsonDecode(dat))).toList();
        // Group dat = listData.singleWhere((element) => element.phoneNumber == data.phoneNumber || element.id == data.id, orElse: () => new Member.Initial());
        // if (dat.id == '') {
        //   listData.add(new Group(id: uuid.v4(), name: data.name, gender: data.gender, phoneNumber: data.phoneNumber, avatarImage: imagePath, group: data.group));
        //   await saveDataToStorage(listData, KEY_MEMBER);
        //   state = Success(state.data);
        // } else {
        //   if (isEdit) {
        //     listData[listData.indexWhere((element) => element.id == data.id)] = data;
        //     await saveDataToStorage(listData, KEY_MEMBER);
        //     state = Success(state.data);
        //   } else {
        //     const err = 'Duplicate Data, Please use Edit Data Instead';
        //     state = Error(err, state.data);
        //     print(err);
        //   }
        // }
      }

    }catch(exception){
      print('Something Went Wrong with Form Member Add: ${exception}');
      state = Error(exception.toString(), state.data);
    }
  }

  void loadData(String id) async {
    state = Loading(state.data);
    try{
      var storageData = await _storage.read(key: KEY_MEMBER);

      if (storageData == null) {
        state = Error('No Data Found! Storage Empty!', state.data);
        print('No Data Found! Storage Empty!');
      } else {
        var listString = List.from(jsonDecode(storageData));
        List<Group> listData = listString.map((dat) => new Group.fromJson(jsonDecode(dat))).toList();
        Group dat = listData.singleWhere((element) => element.id == id, orElse: () => new Group.Initial());
        if (dat.id == '') {
          state = Error('No Data Found!', state.data);
          print('No Data Found!');
        } else {
          state = Initial(dat);
        }
      }

    }catch(exception){
      print('Something Went Wrong with Form Member Add: ${exception}');
      state = Error(exception.toString(), state.data);
    }
  }

  saveDataToStorage(var data, String keyDb) async {
    try{
      String datas = jsonEncode(data);
      await _storage.write(key: keyDb, value: datas);
    }catch(e) {
      print('Something Wrong: ${e.toString()}');
      throw new Exception(e);
    }
  }

}

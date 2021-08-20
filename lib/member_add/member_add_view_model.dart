import 'dart:convert';

import 'package:darisan/core/common/async_state.dart';
import 'package:darisan/core/common/keys.dart';
import 'package:darisan/core/models/member.dart';
import 'package:darisan/core/providers/storage_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:uuid/uuid.dart';


final memberAddViewModelProvider =
StateNotifierProvider.autoDispose<MemberAddViewModel, AsyncState<Member>>(
        (ref) => MemberAddViewModel(ref.read(storageProvider)));

class MemberAddViewModel extends StateNotifier<AsyncState<Member>> {
  final FlutterSecureStorage _storage;

  MemberAddViewModel(this._storage) : super( Initial(new Member.Initial()));

  void setState(String val, String field) {
    // state = Loading(state.data);
    try{
      switch(field){
        case 'name':
          state = Initial(state.data.copyWith(group: state.data.group, name: val, phoneNumber: state.data.phoneNumber, avatarImage: state.data.avatarImage, gender: state.data.gender));
          break;
        case 'phone':
          state = Initial(state.data.copyWith(group: state.data.group, name: state.data.name, avatarImage: state.data.avatarImage, gender: state.data.gender, phoneNumber: val));
          break;
        case 'avatar':
          state = Initial(state.data.copyWith(group: state.data.group, name: state.data.name, phoneNumber: state.data.phoneNumber, gender: state.data.gender, avatarImage: val));
          break;
        case 'gender':
          state = Initial(state.data.copyWith(group: state.data.group, name: state.data.name, phoneNumber: state.data.phoneNumber, avatarImage: state.data.avatarImage, gender: val));
          break;
      }

    }catch(exception){
      print('Something Went Wrong with Form Member Add: ${exception}');
      state = Error(exception.toString(), state.data);
    }
  }

  void saveData(Member data, bool isEdit) async {
    state = Loading(state.data);
    try{
      var storageData = await _storage.read(key: KEY_MEMBER);
      var uuid = Uuid();
      String imagePath = '';
      if (data.avatarImage == '') {
        if (data.gender == 'Female') {
          imagePath = 'assets/images/def_girl1.png';
        } else {
          imagePath = 'assets/images/def_boy1.png';
        }
      } else {
        imagePath = data.avatarImage;
      }

      if (storageData == null) {
        if (isEdit) {
          throw new Exception('No Data to Update!');
        }
        List<Member> listData = [];
        listData.add(new Member(id: uuid.v4(), name: data.name, gender: data.gender, phoneNumber: data.phoneNumber, avatarImage: imagePath, group: data.group));
        await saveDataToStorage(listData, KEY_MEMBER);
        state = Success(state.data);
      } else {
        var listString = List.from(jsonDecode(storageData));
        List<Member> listData = listString.map((dat) => new Member.fromJson(jsonDecode(dat))).toList();
        Member dat = listData.singleWhere((element) => element.phoneNumber == data.phoneNumber || element.id == data.id, orElse: () => new Member.Initial());
        if (dat.id == '') {
          listData.add(new Member(id: uuid.v4(), name: data.name, gender: data.gender, phoneNumber: data.phoneNumber, avatarImage: imagePath, group: data.group));
          await saveDataToStorage(listData, KEY_MEMBER);
          state = Success(state.data);
        } else {
          if (isEdit) {
            listData[listData.indexWhere((element) => element.id == data.id)] = data;
            await saveDataToStorage(listData, KEY_MEMBER);
            state = Success(state.data);
          } else {
            const err = 'Duplicate Data, Please use Edit Data Instead';
            state = Error(err, state.data);
            print(err);
          }
        }
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
        List<Member> listData = listString.map((dat) => new Member.fromJson(jsonDecode(dat))).toList();
        Member dat = listData.singleWhere((element) => element.id == id, orElse: () => new Member.Initial());
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

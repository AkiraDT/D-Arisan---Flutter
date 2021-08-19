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
          state = Initial(state.data.copyWith(group: state.data.group, name: val));
          break;
        case 'phone':
          state = Initial(state.data.copyWith(group: state.data.group, phoneNumber: val));
          break;
        case 'avatar':
          state = Initial(state.data.copyWith(group: state.data.group, avatarImage: val));
          break;
        case 'gender':
          state = Initial(state.data.copyWith(group: state.data.group, gender: val));
          break;
      }

    }catch(exception){
      print('Something Went Wrong with Form Member Add: ${exception}');
      state = Error(exception.toString(), state.data);
    }
  }

  void saveData(Member data) async {
    state = Loading(state.data);
    try{
      var storageData = await _storage.read(key: KEY_MEMBER);
      var uuid = Uuid();

      if (storageData == null) {
        List<Member> listData = [];
        listData.add(new Member(id: uuid.v4(), name: data.name, gender: data.gender, phoneNumber: data.phoneNumber, avatarImage: data.avatarImage, group: data.group));
        await saveDataToStorage(listData, KEY_MEMBER);
        state = Success(state.data);
      } else {
        var listString = List.from(jsonDecode(storageData));
        List<Member> listData = listString.map((dat) => new Member.fromJson(jsonDecode(dat))).toList();
        Member dat = listData.singleWhere((element) => element.phoneNumber == data.phoneNumber, orElse: () => new Member.Initial());
        if (dat.phoneNumber == '') {
          listData.add(new Member(id: uuid.v4(), name: data.name, gender: data.gender, phoneNumber: data.phoneNumber, avatarImage: data.avatarImage, group: data.group));
          await saveDataToStorage(listData, KEY_MEMBER);
          state = Success(state.data);
        } else {
          const err = 'Duplicate Data, Please use Edit Data Instead';
          state = Error(err, state.data);
          print(err);
        }
      }

    }catch(exception){
      print('Something Went Wrong with Form Member Add: ${exception}');
      state = Error(exception.toString(), state.data);
    }
  }

  saveDataToStorage(var data, String keyDb) async {
    String datas = jsonEncode(data);
    await _storage.write(key: keyDb, value: datas);
  }

}

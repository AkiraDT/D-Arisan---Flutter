import 'dart:convert';

import 'package:darisan/core/common/async_state.dart';
import 'package:darisan/core/common/keys.dart';
import 'package:darisan/core/models/member.dart';
import 'package:darisan/core/providers/storage_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final memberAddViewModelProvider =
StateNotifierProvider.autoDispose<MemberAddViewModel, AsyncState<Member>>(
        (ref) => MemberAddViewModel(ref.read(storageProvider)));

class MemberAddViewModel extends StateNotifier<AsyncState<Member>> {
  final FlutterSecureStorage _storage;

  MemberAddViewModel(this._storage) : super( Initial(new Member.Initial()));

  void setState(String val, String field) {
    state = Loading(state.data);
    try{
      switch(field){
        case 'name':
          state = Success(state.data.copyWith(group: state.data.group, name: val));
          break;
        case 'phone':
          state = Success(state.data.copyWith(group: state.data.group, phoneNumber: val));
          break;
        case 'avatar':
          state = Success(state.data.copyWith(group: state.data.group, avatarImage: val));
          break;
      }

    }catch(exception){
      print('Something Went Wrong with Form Member Add: ${exception}');
    }
  }

  void saveData(Member data) async {
    try{
      var storageData = await _storage.read(key: KEY_MEMBER);

      if (storageData == null) {
        List<Member> listData = [];
        listData.add(data);
        await saveDataToStorage(listData, KEY_MEMBER);
      } else {
        var listString = List.from(jsonDecode(storageData));
        List<Member> listData = listString.map((dat) => new Member.fromJson(jsonDecode(dat))).toList();
        Member dat = listData.singleWhere((element) => element.phoneNumber == data.phoneNumber, orElse: () => new Member.Initial());
        if (dat.phoneNumber == '') {
          listData.add(data);
          await saveDataToStorage(listData, KEY_MEMBER);
        } else {
          throw new Exception('Duplicate Data, Please use Edit Data Instead');
        }
      }

    }catch(exception){
      print('Something Went Wrong with Form Member Add: ${exception}');
    }
  }

  saveDataToStorage(var data, String keyDb) async {
    String datas = jsonEncode(data);
    await _storage.write(key: keyDb, value: datas);
  }

}

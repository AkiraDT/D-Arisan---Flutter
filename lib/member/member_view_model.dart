import 'dart:convert';

import 'package:darisan/core/common/async_state.dart';
import 'package:darisan/core/common/keys.dart';
import 'package:darisan/core/models/member.dart';
import 'package:darisan/core/providers/storage_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final memberViewModelProvider =
StateNotifierProvider.autoDispose<MemberViewModel, AsyncState<List<Member>>>(
        (ref) => MemberViewModel(ref.read(storageProvider)));

class MemberViewModel extends StateNotifier<AsyncState<List<Member>>> {
  final FlutterSecureStorage _storage;

  MemberViewModel(this._storage) : super(Initial([])) {
    loadData();
  }

  void loadData() async{
    state = Loading(state.data);
    try{
      var storageData = await _storage.read(key: KEY_MEMBER);
      if (storageData == null) {
        state = Success([]);
      } else {
        var listString = List.from(jsonDecode(storageData));
        List<Member> listData = listString.map((e) => new Member.fromJson(jsonDecode(e))).toList();
        state = Success(listData);
      }
    }catch(exception){
      print('Something Went Wrong with Member List: ${exception}');
    }
  }

}

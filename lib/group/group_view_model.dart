import 'dart:convert';

import 'package:darisan/core/common/async_state.dart';
import 'package:darisan/core/common/keys.dart';
import 'package:darisan/core/models/group.dart';
import 'package:darisan/core/providers/storage_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final groupViewModelProvider =
StateNotifierProvider.autoDispose<GroupViewModel, AsyncState<List<Group>>>(
        (ref) => GroupViewModel(ref.read(storageProvider)));

class GroupViewModel extends StateNotifier<AsyncState<List<Group>>> {
  final FlutterSecureStorage _storage;

  GroupViewModel(this._storage) : super(Initial([])) {
    loadData();
  }

  void loadData() async{
    state = Loading(state.data);
    try{
      var storageData = await _storage.read(key: KEY_GROUP);
      if (storageData == null) {
        state = Success([]);
      } else {
        var listString = List.from(jsonDecode(storageData));
        List<Group> listData = listString.map((e) => new Group.fromJson(jsonDecode(e))).toList();
        state = Success(listData);
      }
    }catch(exception){
      print('Something Went Wrong with Group List: ${exception}');
    }
  }

}

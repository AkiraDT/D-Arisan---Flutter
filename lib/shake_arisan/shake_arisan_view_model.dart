import 'dart:convert';
import 'dart:math';

import 'package:darisan/core/common/async_state.dart';
import 'package:darisan/core/common/keys.dart';
import 'package:darisan/core/models/member.dart';
import 'package:darisan/core/providers/storage_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:uuid/uuid.dart';


final shakeArisanViewModelProvider =
StateNotifierProvider.autoDispose<ShakeArisanViewModel, AsyncState<Member>>(
        (ref) => ShakeArisanViewModel(ref.read(storageProvider)));

class ShakeArisanViewModel extends StateNotifier<AsyncState<Member>> {
  final FlutterSecureStorage _storage;

  ShakeArisanViewModel(this._storage) : super( Initial(new Member.Initial()));

  void shakeIt() async {
    state = Loading(state.data);
    try{
      var storageData = await _storage.read(key: KEY_MEMBER);

      Future.delayed(Duration(milliseconds: 3000), () {
        if (storageData == null) {
          state = Error('No Data Found! Storage Empty!', state.data);
          print('No Data Found! Storage Empty!');
        } else {
          var listString = List.from(jsonDecode(storageData));
          List<Member> listData = listString.map((dat) => new Member.fromJson(jsonDecode(dat))).toList();
          Random rand = new Random();
          String choosenId = listData.elementAt(rand.nextInt(listData.length)).id;

          Member dat = listData.singleWhere((element) => element.id == choosenId, orElse: () => new Member.Initial());
          if (dat.id == '') {
            state = Error('No Data Found!', state.data);
            print('No Data Found!');
          } else {
            state = Success(dat);
          }
        }
      });

    }catch(exception){
      print('Something Went Wrong with Form Member Add: ${exception}');
      state = Error(exception.toString(), state.data);
    }
  }


}

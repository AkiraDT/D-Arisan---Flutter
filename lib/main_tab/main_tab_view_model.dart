import 'package:darisan/group/group_screen.dart';
import 'package:darisan/member/member_screen.dart';
import 'package:darisan/shake_arisan/shake_arisan_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final mainTabViewModelProvider = StateNotifierProvider((ref) => MainTabViewModel());

class MainTabViewModel extends StateNotifier {
  MainTabViewModel() : super(0);

  void onTapTab(int index) {
    state = index;
  }

  void update(int index) {
    state = index;
  }

  Widget getScreen(int index) {
    switch (index) {
      case 0:
        return MemberScreen();
      case 1:
        return GroupScreen();
      case 2:
        return ShakeArisanScreen();
      case 3:
        return GroupScreen();
      case 4:
        return MemberScreen();
      default:
        return MemberScreen();
    }
  }
}
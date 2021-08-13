import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../main_tab_view_model.dart';

class CustomBottomNavigation extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final _index = watch(mainTabViewModelProvider);

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Theme.of(context).buttonColor,
      currentIndex: _index,
      onTap: (index) =>
          context.read(mainTabViewModelProvider.notifier).onTapTab(index),
      selectedLabelStyle: TextStyle(fontSize: 12),
      unselectedLabelStyle: TextStyle(fontSize: 12),
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.black38,
      showUnselectedLabels: true,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: Container(
                height: 25,
                margin: EdgeInsets.only(bottom: 5),
                child: Icon(Icons.person, size: 30,)
            ),
            label: 'Member'),
        BottomNavigationBarItem(
            icon: Container(
                height: 25,
                // margin: EdgeInsets.only(bottom: 5),
                child: Icon(Icons.group, size: 30,)
            ),
            label: 'Group'),
        BottomNavigationBarItem(
            icon: Container(
                height: 25,
                margin: EdgeInsets.only(bottom: 5),
                child: Icon(Icons.screen_rotation, size: 30,)),
            label: 'Shake'),
        BottomNavigationBarItem(
            icon: Container(
                height: 25,
                margin: EdgeInsets.only(bottom: 5),
                child: Icon(Icons.monetization_on, size: 30,)),
            label: 'Winner'),
        BottomNavigationBarItem(
            icon: Container(
                height: 25,
                margin: EdgeInsets.only(bottom: 5),
                child: Icon(Icons.view_list, size: 30,)),
            label: 'Bill'),
      ],
    );
  }

}
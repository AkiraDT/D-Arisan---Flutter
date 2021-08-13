import 'package:darisan/main_tab/widget/bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'main_tab_view_model.dart';

class MainTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(builder: (context, watch, child) {
        final _index = watch(mainTabViewModelProvider);
        return context.read(mainTabViewModelProvider.notifier).getScreen(_index);
      }),
      bottomNavigationBar: CustomBottomNavigation(),
    );
  }
}

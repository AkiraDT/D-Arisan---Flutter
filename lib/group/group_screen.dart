import 'package:darisan/core/common/async_state.dart';
import 'package:darisan/core/widget/loading_circle.dart';
import 'package:darisan/core/widget/main_app_bar.dart';
import 'package:darisan/group/widget/group_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'group_view_model.dart';

class GroupScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar('Group'),
      body: Container(
          margin: EdgeInsets.all(5),
          height: double.infinity,
          width: double.infinity,
          child: Consumer(builder: (context, watch, widget) {
            final state = watch(groupViewModelProvider);

            if (state is Success && state.data.length > 0) {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.data.length,
                  itemBuilder: (context, index) {
                    return GroupCard(groupData: state.data[index],);
                  }
              );
            } else if (state is Success && state.data.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('No Data Found!'),
                    ElevatedButton(
                      onPressed: () => context
                          .refresh(groupViewModelProvider)
                          .loadData(),
                      child: Text("Try again"),
                    ),
                  ],
                ),
              );
            } else if (state is Error) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Something Went Wrong, Try Again!'),
                    ElevatedButton(
                      onPressed: () => context
                          .refresh(groupViewModelProvider)
                          .loadData(),
                      child: Text("Try again"),
                    ),
                  ],
                ),
              );
            }
            return LoadingCircle();
          },)
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/addGroup'),
        tooltip: 'Add Group',
        child: Icon(Icons.add, color: Colors.white,),
        backgroundColor: Theme.of(context).buttonColor,
      ),
    );
  }

}
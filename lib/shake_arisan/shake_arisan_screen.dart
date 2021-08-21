import 'dart:math';

import 'package:darisan/core/common/async_state.dart';
import 'package:darisan/core/widget/loading_circle.dart';
import 'package:darisan/member/widget/member_detail.dart';
import 'package:darisan/shake_arisan/shake_arisan_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShakeArisanScreen extends StatefulWidget{
  @override
  _ShakeArisanScreenState createState() => _ShakeArisanScreenState();

}

class _ShakeArisanScreenState extends State<ShakeArisanScreen> with TickerProviderStateMixin{
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this, duration: Duration(seconds: 5), upperBound: pi * 2);
    animationController.forward();
    animationController.addListener(() {
      setState(() {
        if (animationController.status == AnimationStatus.completed) {
          animationController.repeat();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, child) {
      final state = watch(shakeArisanViewModelProvider);

      if (state is Loading) {
        return Center(
          child: AnimatedBuilder(
            animation: animationController,
            child: CircleAvatar(
              radius: 80,
              backgroundImage: AssetImage('assets/images/shake.png'),
            ),
            builder: (context, widget) {
              return Transform.rotate(
                angle: animationController.value,
                child: widget,
              );
            },
          ),
        );
      } else if (state is Success) {
        return Column(
          children: [
            MemberDetail(name: state.data.name, gender: state.data.gender, phoneNumber: state.data.phoneNumber, avatarImage: state.data.avatarImage, group: state.data.group),
            TextButton(onPressed: () => context.read(shakeArisanViewModelProvider.notifier).shakeIt(), child: Text('Shake Again'))
          ],
        );
      }

      return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Let\'s Shake it!'),
              Divider(
                height: 10,
              ),
              InkWell(
                onTap: () => context.read(shakeArisanViewModelProvider.notifier).shakeIt(),
                child: CircleAvatar(
                  radius: 80,
                  backgroundImage: AssetImage('assets/images/shake.png'),
                ),
              )
            ],
          ),
        );

    },);
  }

}
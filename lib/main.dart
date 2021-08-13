import 'package:darisan/main_tab/main_tab_screen.dart';
import 'package:darisan/member_add/member_add_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(child:MyApp()));
}

class MyApp extends StatelessWidget {
  MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    final swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    strengths.forEach((strength) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    });
    return MaterialColor(color.value, swatch);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'D\'Arisan',
      theme: ThemeData(
        primarySwatch: createMaterialColor(Color(0xff29ABE2)),
        // primarySwatch: createMaterialColor(Color(0xff47C7F4)),
        // fontFamily: 'SFProText',
        accentColor: Colors.white,
        // primaryColor: colorCustom,
        scaffoldBackgroundColor: Colors.white,
        buttonColor: Colors.blueAccent,
        // textTheme: TextTheme(
        //   headline1: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        //   headline2: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        //   headline3: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        //   headline4: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        //   headline5: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        //   headline6: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        // ),
      ),
      home: MainTab(),
      routes: {
        '/addMember': (context) => MemberAddScreen(),
      },
    );
  }
}
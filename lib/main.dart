import 'package:digital_notice_board/comments.dart';
import 'package:digital_notice_board/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        initialRoute: '/home', routes: {
      '/home':(context)=>HomePage(),
      '/comments':(context)=>Comments(),

    },

      home:HomePage()
    );
  }
}

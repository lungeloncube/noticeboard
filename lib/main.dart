import 'package:digital_notice_board/comments.dart';
import 'package:digital_notice_board/home.dart';
import 'package:digital_notice_board/landing_page.dart';
import 'package:digital_notice_board/reminder.dart';
import 'package:digital_notice_board/share_post.dart';
import 'package:flutter/material.dart';

Future<void> main() async {

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        initialRoute: '/landing', routes: {
          '/landing':(context)=> LandingPage(),
      '/home':(context)=>HomePage(),
      '/comments':(context)=>Comments(),
      '/sharePost':(context)=>SharePost(),
      '/reminder':(context)=>ReminderPage(),

    },

      //home:HomePage()
      home:LandingPage()
    );
  }
}

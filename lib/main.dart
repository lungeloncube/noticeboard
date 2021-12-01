import 'package:digital_notice_board/comment_reply.dart';
import 'package:digital_notice_board/comments.dart';
import 'package:digital_notice_board/home.dart';
import 'package:digital_notice_board/landing_page.dart';
import 'package:digital_notice_board/reminder.dart';
import 'package:digital_notice_board/share_post.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as dev;

Future<void> main() async {

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const String LOG_NAME = 'screen.main';
  @override
  Widget build(BuildContext context) {
    dev.log('In main.dart', name: LOG_NAME);
    return MaterialApp(
        initialRoute: '/landing', routes: {
          '/landing':(context)=> LandingPage(),
      '/home':(context)=>HomePage(),
      '/comments':(context)=>Comments(),
      '/sharePost':(context)=>SharePost(),
      '/reminder':(context)=>ReminderPage(),
      '/reply':(context)=>CommentReply(),

    },

      //home:HomePage()
      home:LandingPage()
    );
  }
}
